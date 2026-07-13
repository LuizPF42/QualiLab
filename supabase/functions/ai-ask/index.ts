// ============================================================
// QUALILAB — proxy generico pra Gemini / OpenAI / Anthropic / Azure / custom
// ------------------------------------------------------------
// As chaves COMPARTILHADAS (uma por provedor, opcionais) ficam em secrets do
// projeto Supabase, nunca no front-end. Um pesquisador tambem pode trazer a
// PROPRIA chave (BYOK) — ela viaja so no corpo desta requisicao (body.apiKey),
// e nao e persistida em lugar nenhum aqui (nem log, nem banco); o front-end
// guarda isso so no localStorage do navegador de quem configurou.
//
// CONTROLE DE ACESSO (jul/2026 — antes a funcao era aberta a qualquer um com a
// anon key publica, o que permitia queimar a cota de uma chave do servidor):
//   - BYOK (body.apiKey presente, ou provider custom/azure, que so existem como
//     BYOK): passa SEM exigir sessao — o custo e da chave do proprio pesquisador,
//     e o modo local/arquivo do app nao tem sessao Supabase nenhuma (bloquear
//     aqui quebraria o BYOK offline do app). Este e o caminho
//     PADRAO: o app e BYOK — cada pesquisador traz a propria chave.
//   - Chave DO SERVIDOR (sem body.apiKey): so existe se um secret de provedor
//     (GEMINI_API_KEY etc.) estiver configurado. Sem secret, a funcao responde
//     "informe sua propria chave (BYOK)" e nada mais. Havendo secret, o acesso
//     e restrito a sessoes validas de dominios autorizados (SHARED_KEY_DOMAINS,
//     tambem por secret; vazio por padrao = ninguem usa a chave do servidor).
//   - baseUrl (custom/azure) e validada contra SSRF: so https + dominio publico.
//   - Corpo limitado a MAX_BODY_CHARS; entrada acima disso e recusada com 413.
//
// Recebe { prompt } ou { messages }, mais opcionalmente { provider, apiKey,
// model }, encaminha pro provedor certo, devolve { text, raw } sempre no
// mesmo formato — o front-end nao precisa saber a forma da API de cada um.
//
// Deploy: Supabase Dashboard > Edge Functions > criar/editar funcao "ai-ask" >
// colar este codigo > Deploy. (Sem CLI necessaria.)
// Secret opcional: SHARED_KEY_DOMAINS (csv de dominios com direito a chave do
// servidor; subdominios contam — "exemplo.edu" cobre "sub.exemplo.edu"). Vazio
// por padrao: sem dominios definidos, a chave do servidor fica indisponivel (so BYOK).
// ============================================================

import { createClient } from 'npm:@supabase/supabase-js@2';

const SHARED_KEYS: Record<string, string | undefined> = {
  gemini: Deno.env.get('GEMINI_API_KEY'),
  openai: Deno.env.get('OPENAI_API_KEY'),
  anthropic: Deno.env.get('ANTHROPIC_API_KEY'),
};
const DEFAULT_MODELS: Record<string, string> = {
  gemini: Deno.env.get('GEMINI_MODEL') || 'gemini-3.1-flash-lite',
  openai: Deno.env.get('OPENAI_MODEL') || 'gpt-5.4',
  anthropic: Deno.env.get('ANTHROPIC_MODEL') || 'claude-sonnet-4-6',
};
const MAX_TOKENS = 8192;            // trava de seguranca da SAIDA, independente do que o front pedir
const MAX_BODY_CHARS = 2_000_000;   // trava da ENTRADA (o app respeita IA_TOTAL_CHAR_LIMIT, bem menor)
const FETCH_TIMEOUT_MS = 60_000;    // por tentativa; NAO baixar — provedores BYOK lentos (raciocinio/Azure) chegam a ~50s/resposta
// A Edge Function tem teto de wall-clock de ~150s na plataforma Supabase: passou disso, o worker
// e MORTO com HTTP 546, sem nem rodar o catch la embaixo — o front so ve "Erro 546" cru (sem
// mensagem). O retry de 3x FETCH_TIMEOUT_MS (=180s) sozinho ja ultrapassava esse teto quando o
// provedor era lento, GARANTINDO 546 em qualquer tentativa repetida. Por isso fetchRetry respeita
// um PRAZO GLOBAL abaixo do teto: se nao cabe outra tentativa util, devolve erro limpo (504) em vez
// de ser morto. (Diagnosticado nos logs: um request de 150.112ms morreu em 546; vizinhos de ~50s OK.)
const WALL_CLOCK_BUDGET_MS = 135_000;  // deadline global < ~150s do teto (margem pra parse + montar resposta)
const MIN_ATTEMPT_MS = 15_000;         // nao inicia tentativa sem ao menos isso de orcamento restante
const SHARED_KEY_DOMAINS = (Deno.env.get('SHARED_KEY_DOMAINS') || '')
  .split(',').map(s => s.trim().toLowerCase()).filter(Boolean);

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
};

// erro com status proprio (validacao = 4xx; o catch generico continua 500)
class HttpError extends Error {
  status: number;
  constructor(status: number, msg: string) { super(msg); this.status = status; }
}

// corpo de erro do provedor e truncado antes de voltar pro cliente — evita
// despejar paginas de HTML/stack do upstream (e qualquer URL interna) na UI
const trunc = (s: string, n = 600) => (s.length > n ? s.slice(0, n) + '…' : s);

// valida a sessao do chamador contra o Auth do proprio projeto (o JWT vem no
// header Authorization; o front manda o token da sessao quando existe)
async function getCaller(req: Request) {
  const authHeader = req.headers.get('Authorization') || '';
  if (!/^Bearer .+/i.test(authHeader)) return null;
  const url = Deno.env.get('SUPABASE_URL');
  const anon = Deno.env.get('SUPABASE_ANON_KEY');
  if (!url || !anon) return null;
  try {
    const sb = createClient(url, anon, {
      global: { headers: { Authorization: authHeader } },
      auth: { persistSession: false, autoRefreshToken: false },
    });
    const { data, error } = await sb.auth.getUser();
    if (error) return null;
    return data?.user ?? null;
  } catch (_e) { return null; }
}

function sharedKeyAllowed(user: { email?: string | null } | null) {
  const email = String(user?.email || '').toLowerCase();
  const domain = email.split('@')[1] || '';
  if (!domain) return false; // sessao anonima nao tem e-mail
  return SHARED_KEY_DOMAINS.some(d => domain === d || domain.endsWith('.' + d));
}

// anti-SSRF: a funcao faz POST pra baseUrl vinda do corpo (custom/azure) — sem
// isso ela vira um proxy aberto contra a rede interna da edge runtime. Exige
// https + dominio publico (tuneis tipo ngrok/cloudflared ja dao os dois).
function assertPublicBaseUrl(raw: unknown) {
  let u: URL;
  try { u = new URL(String(raw)); } catch { throw new HttpError(400, 'URL base inválida'); }
  if (u.protocol !== 'https:') {
    throw new HttpError(400, 'A URL base precisa usar https:// (túneis como ngrok/cloudflared já fornecem HTTPS)');
  }
  const h = u.hostname.toLowerCase();
  const ipV4 = /^\d{1,3}(\.\d{1,3}){3}$/.test(h);
  const ipV6 = h.includes(':');
  if (ipV4 || ipV6 || h === 'localhost' || h.endsWith('.localhost') || h.endsWith('.local') || h.endsWith('.internal')) {
    throw new HttpError(400, 'A URL base precisa ser um domínio público (IPs e endereços internos não são aceitos)');
  }
}

// Tentativas com backoff exponencial em erros TRANSITORIOS do provedor: 429 (rate limit),
// 503 (UNAVAILABLE/"high demand"), 500/502/504. Erros definitivos (401 chave invalida,
// 400 request ruim) NAO sao reentados. Cada tentativa tem timeout proprio, E o conjunto
// respeita WALL_CLOCK_BUDGET_MS pra nunca ser morto com 546 pela plataforma (ver acima).
const TRANSIENT = new Set([429, 500, 502, 503, 504]);
const isTimeoutErr = (e: any) => !!e && (e.name === 'TimeoutError' || e.name === 'AbortError');
async function fetchRetry(url: string, init: RequestInit, attempts = 3): Promise<Response> {
  const deadline = Date.now() + WALL_CLOCK_BUDGET_MS;
  let last: Response | undefined;
  let lastErr: unknown;
  for (let i = 0; i < attempts; i++) {
    const remaining = deadline - Date.now();
    if (remaining < MIN_ATTEMPT_MS) break;  // sem orcamento pra outra tentativa util — para ANTES do 546
    try {
      // o timeout da tentativa nunca passa do que resta do prazo global
      const res = await fetch(url, { ...init, signal: AbortSignal.timeout(Math.min(FETCH_TIMEOUT_MS, remaining)) });
      if (!TRANSIENT.has(res.status)) return res;
      last = res;  // transitorio: guarda e tenta de novo (vira erro do provedor se as tentativas acabarem)
    } catch (e) {
      lastErr = e;
    }
    const backoff = 500 * Math.pow(2, i) + Math.random() * 300;
    if (deadline - Date.now() - backoff < MIN_ATTEMPT_MS) break;  // nao espera o backoff se nao sobra tentativa depois
    await new Promise(r => setTimeout(r, backoff));
  }
  if (last) return last;  // ultima resposta transitoria -> o call* correspondente a transforma em erro do provedor
  // estourou o prazo sem resposta: se foi timeout, mensagem acionavel (senao propaga o erro real de rede)
  if (isTimeoutErr(lastErr)) {
    throw new HttpError(504, 'O provedor de IA demorou demais para responder (a função tem limite de ~150s). Reduza o material selecionado ou escolha um modelo mais rápido.');
  }
  throw (lastErr ?? new HttpError(504, 'Sem resposta do provedor de IA dentro do tempo limite.'));
}

// chave no HEADER (x-goog-api-key), nunca na query string: uma URL invalida ou
// erro de rede poderia ecoar a URL inteira (com a chave) na mensagem de erro.
async function callGemini(apiKey: string, model: string, systemParts: string[], contents: any[], opts: any) {
  const url = `https://generativelanguage.googleapis.com/v1beta/models/${encodeURIComponent(model)}:generateContent`;
  const res = await fetchRetry(url, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', 'x-goog-api-key': apiKey },
    body: JSON.stringify({
      contents: contents.map(m => ({ role: m.role === 'assistant' ? 'model' : 'user', parts: [{ text: m.content }] })),
      ...(systemParts.length ? { systemInstruction: { parts: [{ text: systemParts.join('\n') }] } } : {}),
      generationConfig: {
        temperature: opts.temperature ?? 0.3,
        maxOutputTokens: Math.min(opts.max_tokens || MAX_TOKENS, MAX_TOKENS),
        ...(opts.json ? { responseMimeType: 'application/json' } : {}),
      },
    }),
  });
  if (!res.ok) throw new Error(`Gemini API (${res.status}): ${trunc(await res.text())}`);
  const data = await res.json();
  const text = data.candidates?.[0]?.content?.parts?.map((p: any) => p.text).join('') ?? '';
  return { text, raw: data };
}

// Usa a Responses API (/v1/responses), nao a Chat Completions classica — a serie GPT-5
// quebrou compatibilidade de formas diferentes por modelo (gpt-5.4-mini exige
// max_completion_tokens em vez de max_tokens; gpt-5.4 puro chegou a dar 404 em
// /v1/chat/completions "nao e um chat model"). A Responses API e o endpoint unificado que a
// OpenAI recomenda pra GPT-5.x e continua funcionando pros modelos antigos (gpt-4o etc.).
async function callOpenAI(apiKey: string, model: string, systemParts: string[], contents: any[], opts: any) {
  const input = [
    ...(systemParts.length ? [{ role: 'system', content: systemParts.join('\n') }] : []),
    ...contents.map(m => ({ role: m.role, content: m.content })),
  ];
  const res = await fetchRetry('https://api.openai.com/v1/responses', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', Authorization: `Bearer ${apiKey}` },
    body: JSON.stringify({
      model,
      input,
      temperature: opts.temperature ?? 0.3,
      max_output_tokens: Math.min(opts.max_tokens || MAX_TOKENS, MAX_TOKENS),
    }),
  });
  if (!res.ok) throw new Error(`OpenAI API (${res.status}): ${trunc(await res.text())}`);
  const data = await res.json();
  // "output_text" e um campo de conveniencia (string unica) que a API costuma incluir; se
  // nao vier, monta concatenando os blocos de texto de data.output[].content[].
  const text = data.output_text
    ?? (data.output ?? [])
        .filter((item: any) => item.type === 'message')
        .flatMap((item: any) => (item.content ?? []).filter((c: any) => c.type === 'output_text').map((c: any) => c.text))
        .join('')
    ?? '';
  return { text, raw: data };
}

// Provedor "personalizado": qualquer API compativel com o formato classico da OpenAI
// (/chat/completions) — cobre DeepSeek, Mistral, Qwen (hospedados) e servidores locais
// como Ollama/vLLM expostos numa URL acessivel por esta function (Supabase Edge nao
// alcanca localhost da maquina do pesquisador; precisa de URL publica, ex. via tunel).
// O pesquisador preenche baseUrl + apiKey (opcional, servidores locais costumam nao exigir)
// + model — tudo isso e enviado no corpo da requisicao, nada fica configurado no servidor.
async function callCustom(baseUrl: string, apiKey: string, model: string, systemParts: string[], contents: any[], opts: any) {
  const url = `${baseUrl.replace(/\/+$/, '')}/chat/completions`;
  const messages = [
    ...(systemParts.length ? [{ role: 'system', content: systemParts.join('\n') }] : []),
    ...contents.map(m => ({ role: m.role, content: m.content })),
  ];
  const res = await fetchRetry(url, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', ...(apiKey ? { Authorization: `Bearer ${apiKey}` } : {}) },
    body: JSON.stringify({
      model,
      messages,
      temperature: opts.temperature ?? 0.3,
      max_tokens: Math.min(opts.max_tokens || MAX_TOKENS, MAX_TOKENS),
    }),
  });
  if (!res.ok) throw new Error(`API personalizada (${res.status}): ${trunc(await res.text())}`);
  const data = await res.json();
  const text = data.choices?.[0]?.message?.content ?? '';
  return { text, raw: data };
}

// Azure OpenAI — superficie "v1" (baseUrl termina em /openai/v1, ex.:
// https://SEU-RECURSO.openai.azure.com/openai/v1). Mesmo formato classico de
// chat completions da OpenAI (/chat/completions, body {model,messages,...},
// resposta em choices[0].message.content), mas com DUAS diferencas: a
// autenticacao e por header "api-key" (nao "Authorization: Bearer"), e o "model"
// e o nome do DEPLOYMENT criado no portal do Azure (nao o nome do modelo base).
// baseUrl + apiKey + model vem todos do corpo (BYOK, igual ao custom). A chave e
// obrigatoria aqui (o Azure sempre exige), diferente do custom.
async function callAzure(baseUrl: string, apiKey: string, model: string, systemParts: string[], contents: any[], opts: any) {
  const url = `${baseUrl.replace(/\/+$/, '')}/chat/completions`;
  const messages = [
    ...(systemParts.length ? [{ role: 'system', content: systemParts.join('\n') }] : []),
    ...contents.map(m => ({ role: m.role, content: m.content })),
  ];
  const res = await fetchRetry(url, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', 'api-key': apiKey },
    body: JSON.stringify({
      model,
      messages,
      temperature: opts.temperature ?? 0.3,
      max_tokens: Math.min(opts.max_tokens || MAX_TOKENS, MAX_TOKENS),
    }),
  });
  if (!res.ok) throw new Error(`Azure OpenAI (${res.status}): ${trunc(await res.text())}`);
  const data = await res.json();
  const text = data.choices?.[0]?.message?.content ?? '';
  return { text, raw: data };
}

async function callAnthropic(apiKey: string, model: string, systemParts: string[], contents: any[], opts: any) {
  const res = await fetchRetry('https://api.anthropic.com/v1/messages', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json', 'x-api-key': apiKey, 'anthropic-version': '2023-06-01' },
    body: JSON.stringify({
      model,
      max_tokens: Math.min(opts.max_tokens || MAX_TOKENS, MAX_TOKENS),
      temperature: opts.temperature ?? 0.3,
      ...(systemParts.length ? { system: systemParts.join('\n') } : {}),
      messages: contents.map(m => ({ role: m.role, content: m.content })),
    }),
  });
  if (!res.ok) throw new Error(`Anthropic API (${res.status}): ${trunc(await res.text())}`);
  const data = await res.json();
  const text = (data.content ?? []).filter((b: any) => b.type === 'text').map((b: any) => b.text).join('') ?? '';
  return { text, raw: data };
}

// Normaliza o "usage" (contagem de tokens REAL da resposta) de cada provedor pra um formato unico
// { input, output, cached } — pro front-end estimar custo (calculadora de custo da IA). input = total
// de tokens de ENTRADA (inclui os servidos de cache); output = tokens de SAIDA; cached = porcao de
// entrada servida de cache (subconjunto de input). ATENCAO: a Anthropic reporta input_tokens SEM o
// cache, entao somamos cache_read + cache_creation pra obter o total de entrada processada.
function normUsage(provider: string, data: any) {
  try {
    if (provider === 'gemini') {
      const u = data?.usageMetadata || {};
      return { input: u.promptTokenCount ?? 0, output: u.candidatesTokenCount ?? 0, cached: u.cachedContentTokenCount ?? 0 };
    }
    if (provider === 'openai') {
      const u = data?.usage || {};
      return { input: u.input_tokens ?? 0, output: u.output_tokens ?? 0, cached: u.input_tokens_details?.cached_tokens ?? 0 };
    }
    if (provider === 'anthropic') {
      const u = data?.usage || {};
      const cacheRead = u.cache_read_input_tokens ?? 0, cacheCreate = u.cache_creation_input_tokens ?? 0;
      return { input: (u.input_tokens ?? 0) + cacheRead + cacheCreate, output: u.output_tokens ?? 0, cached: cacheRead };
    }
    // custom / azure (formato classico OpenAI chat completions)
    const u = data?.usage || {};
    return { input: u.prompt_tokens ?? 0, output: u.completion_tokens ?? 0, cached: u.prompt_tokens_details?.cached_tokens ?? 0 };
  } catch (_e) { return { input: 0, output: 0, cached: 0 }; }
}

Deno.serve(async (req: Request) => {
  if (req.method === 'OPTIONS') return new Response('ok', { headers: corsHeaders });

  try {
    // trava de entrada ANTES do parse — corpo gigante nem chega ao provedor
    const rawBody = await req.text();
    if (rawBody.length > MAX_BODY_CHARS) {
      throw new HttpError(413, 'Requisição grande demais — reduza a seleção de material');
    }
    let body: any = {};
    try { body = JSON.parse(rawBody || '{}'); } catch (_e) { throw new HttpError(400, 'Corpo da requisição não é JSON válido'); }

    const provider = String(body.provider || 'gemini').toLowerCase();
    if (!['gemini', 'openai', 'anthropic', 'custom', 'azure'].includes(provider)) {
      throw new HttpError(400, `Provedor "${provider}" não suportado (use gemini, openai, anthropic, azure ou custom)`);
    }

    // provedores "custom" e "azure": sem secret/modelo compartilhado no servidor — tudo
    // (URL, chave, modelo) vem do corpo da requisicao, preenchido pelo pesquisador.
    let apiKey: string;
    let model: string;
    if (provider === 'custom' || provider === 'azure') {
      const nome = provider === 'azure' ? 'Azure OpenAI' : 'provedor personalizado';
      if (!body.baseUrl) throw new HttpError(400, `Parâmetro "baseUrl" é obrigatório para o ${nome}`);
      if (!body.model) throw new HttpError(400, `Parâmetro "model" é obrigatório para o ${nome}`);
      // Azure sempre exige chave; no custom ela e opcional (servidores locais podem nao exigir).
      if (provider === 'azure' && !body.apiKey) throw new HttpError(400, 'Parâmetro "apiKey" é obrigatório para o Azure OpenAI');
      assertPublicBaseUrl(body.baseUrl);
      apiKey = body.apiKey || '';
      model = body.model;
    } else if (body.apiKey) {
      // BYOK: a chave que o pesquisador trouxe tem prioridade e nao exige sessao —
      // o custo e dele, e o modo local/arquivo nao tem sessao Supabase. So transita.
      apiKey = body.apiKey;
      model = body.model || DEFAULT_MODELS[provider];
    } else {
      // Sem body.apiKey: tenta a chave configurada no servidor por secret (opcional).
      const serverKey = SHARED_KEYS[provider] || '';
      if (!serverKey) {
        // Nenhuma chave no servidor pra esse provedor — o app e BYOK: o pesquisador traz a sua.
        // (Estado padrao: sem secret configurado, este e o unico caminho, e nada mais e revelado.)
        throw new HttpError(400, 'Nenhuma chave de IA configurada — informe a sua própria chave (BYOK) em "Minha Conta"');
      }
      // Ha uma chave no servidor: liberada so a sessoes validas de dominios autorizados
      // (SHARED_KEY_DOMAINS, por secret; vazio por padrao = ninguem usa a chave do servidor).
      const user = await getCaller(req);
      if (!user) {
        throw new HttpError(401, 'Esta chave exige uma sessão válida — entre com sua conta, ou configure sua própria chave (BYOK) em "Minha Conta"');
      }
      if (!sharedKeyAllowed(user)) {
        throw new HttpError(403, 'Sua conta não tem acesso à chave do servidor — configure sua própria chave (BYOK) em "Minha Conta"');
      }
      apiKey = serverKey;
      model = body.model || DEFAULT_MODELS[provider];
    }

    // aceita tanto { prompt, system } (uso simples) quanto { messages: [{role,content}] }
    // (formato OpenAI-like, usado pelo chat) — convertido pro formato de cada provedor
    // dentro da funcao call* correspondente.
    const messages = body.messages ?? [
      ...(body.system ? [{ role: 'system', content: String(body.system) }] : []),
      { role: 'user', content: String(body.prompt || '') },
    ];

    if (!Array.isArray(messages) || !messages.length || !messages.some((m: any) => m && m.content)) {
      throw new HttpError(400, 'Parâmetro "prompt" (ou "messages") é obrigatório');
    }

    const systemParts = messages.filter((m: any) => m.role === 'system').map((m: any) => String(m.content || ''));
    const contents = messages
      .filter((m: any) => m.role !== 'system')
      .map((m: any) => ({ role: m.role === 'assistant' ? 'assistant' : 'user', content: String(m.content || '') }));

    const { text, raw } = provider === 'gemini' ? await callGemini(apiKey, model, systemParts, contents, body)
      : provider === 'openai' ? await callOpenAI(apiKey, model, systemParts, contents, body)
      : provider === 'custom' ? await callCustom(String(body.baseUrl), apiKey, model, systemParts, contents, body)
      : provider === 'azure' ? await callAzure(String(body.baseUrl), apiKey, model, systemParts, contents, body)
      : await callAnthropic(apiKey, model, systemParts, contents, body);

    const usage = normUsage(provider, raw);
    return new Response(JSON.stringify({ text, raw, usage }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  } catch (e) {
    const status = e instanceof HttpError ? e.status : 500;
    return new Response(JSON.stringify({ error: trunc(String((e as Error)?.message || e), 800) }), {
      status,
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    });
  }
});
