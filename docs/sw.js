/* ============ SERVICE WORKER do QualiLab (PWA, ago/2026) ============
   O que ele faz, e SO isso:
   1. SHELL OFFLINE, network-first: o index.html e sempre buscado da rede quando ha rede (nunca
      se serve versao velha com rede de pe — o numero do cabecalho continua sendo a verdade), e
      a ultima copia boa responde quando NAO ha (antes, sem rede, digitar a URL dava a pagina de
      erro do navegador — num app cujo argumento e "funciona offline no modo arquivo").
   2. DEPENDENCIAS DE CDN, cache-first: as URLs sao PINADAS em versao exata (decisao do SRI),
      entao sao chave de cache perfeita — imutaveis por construcao. Depois do primeiro uso,
      PDF/OCR/planilha/zip funcionam offline para sempre. O `integrity` do import map continua
      valendo por cima do que sai daqui: o SW serve bytes, o hash confere do mesmo jeito.
   3. NADA de API: Supabase nao passa por aqui (a fila de escrita do app resolve o problema
      certo do jeito certo); so GET e cacheado.
   ATUALIZACAO: o registro (no boot.js) detecta um worker novo em espera e mostra o chip
   "nova versao disponivel · recarregar" na barra de status; o clique manda SKIP_WAITING.
   Sem isso, SW e a maquina de mascarar deploy que o resto do repo existe para evitar. */
const SHELL_CACHE = 'ql-shell-v1';
// v2: the v1 cache may hold unpinned URLs from before pinnedCdnUrl; `activate` drops it.
const DEPS_CACHE = 'ql-deps-v2';
// cdn.sheetjs.com entrou na 1.4.64: o SheetJS passou a vir do fabricante na 1.4.57 (S04) e esta
// lista ficou para tras, entao o app instalado nao importava .xlsx sem rede. A URL de la tambem e
// pinada em versao (xlsx-0.20.3), a mesma condicao que torna o cache-first seguro nos outros dois.
const CDN_HOSTS = ['cdn.jsdelivr.net', 'esm.sh', 'cdn.sheetjs.com'];
/* ONLY a URL that names an exact version is immutable, and so only it may be served cache-first
   (auditoria de out/2026). Before, ANY GET to these hosts was cached forever: an unpinned URL
   (`/npm/pkg/+esm`, a `@latest`, a range) would keep the first copy it ever saw, and the "new
   version" chip of the app would not reach it. Pinned = an `@x.y.z` in the path (jsdelivr and
   esm.sh, including the second hops of the esm.sh shim), the `xlsx-x.y.z/` folder of SheetJS, or
   an esm.sh build path (`/v135/...`, `/stable/...`), which esm.sh itself pins. Anything else goes to
   the network untouched. tests/sw_cdn.test.mjs reads this function out of this file. */
// SW-PINNED-START
function pinnedCdnUrl(u) {
  if (!CDN_HOSTS.includes(u.hostname)) return false;
  const p = u.pathname;
  if (/@\d+\.\d+\.\d+(?:[-+][0-9A-Za-z.-]+)?(?:\/|$)/.test(p)) return true;
  if (u.hostname === 'cdn.sheetjs.com' && /^\/xlsx-\d+\.\d+\.\d+\//.test(p)) return true;
  if (u.hostname === 'esm.sh' && /^\/(?:v\d+|stable)\//.test(p)) return true;
  return false;
}
// SW-PINNED-END

self.addEventListener('install', (e) => {
  /* O worker novo fica em waiting ate o SKIP_WAITING (toast) — mas o PRE-CACHE do shell roda
     JA AQUI, e ele nao e otimizacao: sem ele a promessa do item 1 era falsa na primeira
     sessao. A primeira visita NUNCA e controlada pelo SW que ela registra, e clique de aba e
     mudanca de hash (nao navegacao) — entao "a ultima copia boa" so nascia num F5 que ninguem
     sabe que deve dar. Medido ao vivo (26/ago/2026): instalar o PWA, fechar, derrubar o
     servidor e reabrir dava a pagina de erro do navegador. Falha de rede aqui NAO derruba a
     instalacao (o fallback fica como era: sem copia). */
  e.waitUntil((async () => {
    try {
      const cache = await caches.open(SHELL_CACHE);
      const fresh = await fetch('index.html', { cache: 'no-cache' });
      if (fresh && fresh.ok) await cache.put('index.html', fresh);
    } catch (_) { /* sem rede durante a instalacao: instala mesmo assim */ }
  })());
});

self.addEventListener('activate', (e) => {
  e.waitUntil((async () => {
    /* So apaga caches NOSSOS (prefixo ql-): caches.keys() e por ORIGEM, nao por escopo do
       worker — no Pages a origem (luizpf42.github.io) e compartilhada com qualquer outro
       site da conta, e apagar tudo comeria o cache de um vizinho futuro em silencio. */
    const keep = new Set([SHELL_CACHE, DEPS_CACHE]);
    for (const k of await caches.keys()) if (k.startsWith('ql-') && !keep.has(k)) await caches.delete(k);
    await self.clients.claim();
  })());
});

self.addEventListener('message', (e) => {
  if (e.data && e.data.type === 'SKIP_WAITING') self.skipWaiting();
});

self.addEventListener('fetch', (e) => {
  const req = e.request;
  if (req.method !== 'GET') return;
  const url = new URL(req.url);

  // 1. navegacao (o proprio app): network-first, fallback ao cache
  if (req.mode === 'navigate') {
    e.respondWith((async () => {
      const cache = await caches.open(SHELL_CACHE);
      try {
        const fresh = await fetch(req);
        if (fresh && fresh.ok) cache.put(req, fresh.clone());
        return fresh;
      } catch (_) {
        return (await cache.match(req)) || (await cache.match('index.html')) || Response.error();
      }
    })());
    return;
  }

  // 2. CDN pinada: cache-first (URL com versao exata e imutavel); sem versao, o SW nao toca
  if (pinnedCdnUrl(url)) {
    e.respondWith((async () => {
      const cache = await caches.open(DEPS_CACHE);
      const hit = await cache.match(req);
      if (hit) return hit;
      const fresh = await fetch(req);
      if (fresh && fresh.ok) cache.put(req, fresh.clone());
      return fresh;
    })());
    return;
  }

  // 3. estatico da mesma origem (manifest, icones, corpus de exemplo): stale-while-revalidate
  if (url.origin === self.location.origin) {
    e.respondWith((async () => {
      const cache = await caches.open(SHELL_CACHE);
      const hit = await cache.match(req);
      const refresh = fetch(req).then((fresh) => {
        if (fresh && fresh.ok) cache.put(req, fresh.clone());
        return fresh;
      }).catch(() => null);
      return hit || (await refresh) || Response.error();
    })());
  }
  // demais origens (Supabase, provedor de IA em BYOK): o SW nao toca
});
