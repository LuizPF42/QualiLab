-- ============================================================
-- QUALILAB — backend coletivo (Supabase / Postgres)
-- ------------------------------------------------------------
-- Cole tudo no SQL Editor do Supabase e clique em Run.
-- Idempotente: pode rodar mais de uma vez sem efeitos colaterais.
-- Depois, em Authentication > Providers, habilite Email e
-- (opcional) "Allow anonymous sign-ins" para o modo visitante.
-- ============================================================

-- ---------- tabelas ----------
create table if not exists public.projects (
  id          uuid primary key default gen_random_uuid(),
  name        text not null,
  code        text not null unique,
  mode        text not null default 'collective',   -- individual | collective
  created_at  timestamptz not null default now(),
  created_by  uuid
);
alter table public.projects add column if not exists mode text not null default 'collective';
-- DISTRIBUICAO/CEGO (jul/2026): duas dimensoes ORTOGONAIS, ambas DESLIGADAS por padrao
-- (projeto que ja existe nao muda de comportamento):
--   restrict_docs = membro so ENXERGA os documentos atribuidos a ele (tabela assignments)
--   blind         = membro so ENXERGA as PROPRIAS codificacoes/respostas (true blind)
-- Combinam: cego + o MESMO doc para 2 pessoas = duplo-cego (confiabilidade inter-codificador);
-- restrito + 1 pessoa por doc = divisao de trabalho. Ver can_see_doc/can_see_authored abaixo.
alter table public.projects add column if not exists blind         boolean not null default false;
alter table public.projects add column if not exists restrict_docs boolean not null default false;
-- DESLIGAR A IA POR PROJETO (S7, ago/2026). Um mecanismo serve os DOIS consumidores — a pesquisa
-- que quer se DECLARAR sem IA, e o admin que teme codificacao de modelo entrando como julgamento
-- humano — mudando so o ESCOPO, e e isso que evita dois flags sobrepostos:
--   'none'    ninguem perde nada
--   'members' membros perdem os paineis; admin mantem
--   'all'     todos perdem, admin inclusive (contrato de Ulisses: fecha-se a porta pra nao poder
--             abri-la sob pressa, e pra poder dizer a equipe "ninguem aqui usa, eu inclusive")
-- NAO E FRONTEIRA TECNICA: em BYOK o navegador fala DIRETO com o provedor e qualquer pessoa copia
-- o trecho pra outra aba. O que isto faz e LIMITAR A TAXA, e o dano escala com VOLUME (tres
-- codificacoes por copiar-colar nao movem concordancia; duzentas sugestoes aceitas substituem o
-- julgamento do codificador). O default 'none' e RETROCOMPATIBILIDADE de projeto ANTIGO: projeto
-- novo nunca cai nele, porque a criacao PERGUNTA e nasce desativado.
alter table public.projects add column if not exists restrict_ai text not null default 'none';
-- ESPELHAR BASE: o interruptor do espelho AUTOMATICO antes das operacoes irreversiveis. Ligado por
-- padrao (pedido do autor, 03/set/2026): quem desliga sabe o que perde, e a tela diz o custo em
-- tamanho. Decisao do PROJETO, como restrict_ai — muda pelo set_project_flags (admin) e fica na trilha.
alter table public.projects add column if not exists snapshots_auto boolean not null default true;
alter table public.projects drop constraint if exists projects_restrict_ai_check;
alter table public.projects add constraint projects_restrict_ai_check check (restrict_ai in ('none','members','all'));
-- TRAVA DE UMA VIA. Existe porque o interruptor e REVERSIVEL, e a reversibilidade abre exatamente
-- um buraco na declaracao do Relatorio: da pra ativar, conversar SEM salvar a conversa e desativar
-- de volta, e o bloco (que conta conversas salvas e memorias) diria "os recursos de IA nao foram
-- ativados neste projeto", que e FALSO. Ela registra DISPONIBILIDADE, nunca uso — confundir os
-- dois recria o defeito da frase datada, que PRESSUPUNHA uso anterior.
alter table public.projects add column if not exists ai_ever_enabled boolean not null default false;
-- backfill honesto: projeto que ja existia sempre teve os paineis disponiveis.
update public.projects set ai_ever_enabled = true where restrict_ai <> 'all' and not ai_ever_enabled;

create table if not exists public.members (
  id           uuid primary key default gen_random_uuid(),
  project_id   uuid not null references public.projects(id) on delete cascade,
  user_id      uuid not null,
  display_name text not null default 'anonimo',
  role         text not null default 'member',   -- admin | member | viewer
  joined_at    timestamptz not null default now(),
  unique (project_id, user_id)
);
alter table public.members add column if not exists role text not null default 'member';
update public.members m set role = 'admin'
  from public.projects p
  where m.project_id = p.id and m.user_id = p.created_by and m.role <> 'admin';

create table if not exists public.documents (
  id          uuid primary key default gen_random_uuid(),
  project_id  uuid not null references public.projects(id) on delete cascade,
  name        text not null,
  content     text not null default '',
  created_at  timestamptz not null default now(),
  created_by  uuid
);
-- PDF-BLOCK (Camada 2): o texto+offset continua a espinha; guardar o PDF ORIGINAL e' aditivo.
-- Nos modos arquivo/local os bytes vivem no .qualilab (zip) / IndexedDB. Na NUVEM iriam pro
-- Supabase Storage (bucket 'pdfs', objeto '<doc_id>.pdf') e a linha so marca has_pdf. So com
-- CONSENTIMENTO EXPLICITO (decisao do autor) e planejado como removivel.
alter table public.documents add column if not exists has_pdf boolean not null default false;
-- bucket privado 'pdfs' (bytes como '<doc_id>.pdf') + RLS por MEMBRO do projeto do documento.
-- O front so sobe o PDF pra nuvem com CONSENTIMENTO explicito (cloudPdfConsentOk no index.html).
insert into storage.buckets (id, name, public) values ('pdfs','pdfs',false) on conflict (id) do nothing;
-- As 4 policies do bucket MUDARAM DE LUGAR (jul/2026): passaram a depender de can_see_doc()
-- (distribuicao restritiva), que so pode ser criada depois de is_admin e da tabela assignments.
-- Rodar este arquivo de cima para baixo num banco NOVO falharia aqui. Elas agora ficam na
-- secao RLS, logo apos as policies de doc_values. Ver "RLS: storage (PDF original)".

create table if not exists public.categories (
  id          uuid primary key default gen_random_uuid(),
  project_id  uuid not null references public.projects(id) on delete cascade,
  name        text not null,
  kind        text not null default 'single',     -- single | text | select | date | checkbox | number | boolean
                                                  -- (number/boolean desde ago/2026; sem check constraint de proposito:
                                                  --  o cliente e a autoridade sobre o vocabulario de tipos, e uma
                                                  --  constraint aqui exigiria migracao a cada tipo novo)
  options     jsonb not null default '[]'::jsonb,
  description text not null default '',
  color       int  not null default 0,
  position    int  not null default 0
);
alter table public.categories add column if not exists description text not null default '';

create table if not exists public.doc_values (
  id           uuid primary key default gen_random_uuid(),
  project_id   uuid not null references public.projects(id) on delete cascade,
  document_id  uuid not null references public.documents(id) on delete cascade,
  category_id  uuid not null references public.categories(id) on delete cascade,
  value        text not null default '',
  set_by       uuid,
  author_name  text not null default 'anonimo',
  layer        text not null default 'individual',  -- individual | final (gabarito)
  updated_at   timestamptz not null default now(),
  unique (document_id, category_id, set_by, layer)
);
alter table public.doc_values add column if not exists layer text not null default 'individual';
alter table public.doc_values drop constraint if exists doc_values_document_id_category_id_key;
do $$ begin
  if not exists (select 1 from pg_constraint where conname = 'doc_values_uniq') then
    alter table public.doc_values add constraint doc_values_uniq
      unique (document_id, category_id, set_by, layer);
  end if;
end $$;

create table if not exists public.codes (
  id          uuid primary key default gen_random_uuid(),
  project_id  uuid not null references public.projects(id) on delete cascade,
  parent_id   uuid references public.codes(id) on delete cascade,
  name        text not null,
  hue         int  not null default 0,
  depth       int  not null default 0,
  position    int  not null default 0,
  is_redaction boolean not null default false,
  pos_x       double precision,
  pos_y       double precision
);
alter table public.codes add column if not exists is_redaction boolean not null default false;
-- posicao no "quadro branco espacial" do Esquema (aba Codigos -> Mapa). null = nao posicionado
-- (nao destrutivo: projeto antigo abre normal e recebe placement automatico por familia).
alter table public.codes add column if not exists pos_x double precision;
alter table public.codes add column if not exists pos_y double precision;

create table if not exists public.codings (
  id           uuid primary key default gen_random_uuid(),
  project_id   uuid not null references public.projects(id) on delete cascade,
  document_id  uuid not null references public.documents(id) on delete cascade,
  code_id      uuid not null references public.codes(id) on delete cascade,
  span_start   int  not null,
  span_end     int  not null,
  quote        text not null default '',
  layer        text not null default 'individual',  -- individual | final (consolidada)
  created_by   uuid,
  author_name  text not null default 'anonimo',
  created_at   timestamptz not null default now(),
  pdf_region   jsonb   -- PDF-BLOCK: geometria do retângulo do OCR de área {page,x,y,w,h} (0..1); null = codificação de texto comum
);
alter table public.codings add column if not exists layer text not null default 'individual';
alter table public.codings add column if not exists pdf_region jsonb;   -- PDF-BLOCK (idempotente p/ bancos já criados)
-- S8: PROVENIENCIA — de onde veio o julgamento que criou a linha. 'manual' (default) | 'ai'
-- (sugerido por modelo e aprovado item a item) | 'agreement' (concordancia registrada na
-- Reconciliacao, com a resposta alheia ja visivel). Vocabulario reusado da ia_memory.source.
-- SEM check constraint, seguindo o precedente da ia_memory: valor novo nesta familia e esperado
-- (a propria S8 preve), e um check obrigaria migracao nos dois projetos a cada valor novo.
alter table public.codings add column if not exists source text not null default 'manual';

-- ---------- indices de performance (ago/2026) ----------
-- codings/doc_values sem indice nas FKs mais filtradas causava sequential
-- scan -> timeout no PostgREST ("Thread killed by timeout manager") ->
-- retry do cliente -> estouro de egress no Free Plan. Ver migrations/2026-08-indices-performance.sql.
create index if not exists codings_document_id_idx    on public.codings (document_id);
create index if not exists codings_project_id_idx     on public.codings (project_id);
create index if not exists codings_code_id_idx        on public.codings (code_id);
create index if not exists doc_values_project_id_idx  on public.doc_values (project_id);
create index if not exists doc_values_category_id_idx on public.doc_values (category_id);
create index if not exists documents_project_id_idx   on public.documents (project_id);

-- ---------- distribuicao: quem codifica o que (jul/2026) ----------
-- Uma linha por (documento, pesquisador). Sozinha e so um PLANO de trabalho; vira restricao
-- de verdade quando projects.restrict_docs esta ligado (ver can_see_doc). Serve aos dois
-- caminhos que o autor pediu: divisao de trabalho (1 pessoa por doc) e true blind (o MESMO
-- doc para 2+ pessoas, com projects.blind ligado).
create table if not exists public.assignments (
  id          uuid primary key default gen_random_uuid(),
  project_id  uuid not null references public.projects(id) on delete cascade,
  document_id uuid not null references public.documents(id) on delete cascade,
  user_id     uuid not null,
  assigned_at timestamptz not null default now(),
  assigned_by uuid,
  unique (document_id, user_id)
);
create index if not exists assignments_doc_idx     on public.assignments (document_id, user_id);
create index if not exists assignments_user_idx    on public.assignments (user_id);
create index if not exists assignments_project_idx on public.assignments (project_id);

-- ---------- funções de pertencimento ----------
create or replace function public.is_member(p uuid)
returns boolean language sql security definer stable set search_path = public as $$
  select exists (select 1 from public.members where project_id = p and user_id = auth.uid());
$$;

create or replace function public.is_admin(p uuid)
returns boolean language sql security definer stable set search_path = public as $$
  select exists (select 1 from public.members where project_id = p and user_id = auth.uid() and role = 'admin');
$$;

-- PAPEL 'viewer' (somente leitura, ago/2026): le tudo o que um membro le — as MESMAS restricoes
-- de blind e restrict_docs continuam valendo, nao ha caminho de visibilidade novo — e nao muda
-- material nenhum. E o orientador, o parecerista, o colega que le e devolve leitura.
-- can_edit e a fronteira: onde uma policy de ESCRITA dizia is_member, hoje diz can_edit.
create or replace function public.can_edit(p uuid)
returns boolean language sql security definer stable set search_path = public as $$
  select exists (select 1 from public.members
                 where project_id = p and user_id = auth.uid() and role <> 'viewer');
$$;

-- A EXCECAO DO VIEWER E O MEMO — ele COMENTA —, mas a tabela `memos` guarda DUAS coisas
-- diferentes: nota E configuracao do estudo (os seis ai_*, o ai_prompt e o cloud_stopwords).
-- Configuracao nao e comentario: mexer nela muda o que a IA recebe e o que a nuvem de palavras
-- ignora, ou seja decisao metodologica. Esta funcao e a linha entre as duas, e ela e a mesma
-- distincao que o MEMO_PROJECT_SCOPES do cliente ja fazia por outro motivo.
-- ESCOPO NOVO DE NOTA entra aqui; escopo novo de CONFIG nao entra, e fica fechado por default.
create or replace function public.memo_is_note(p_scope text)
returns boolean language sql immutable set search_path = public as $$
  select p_scope in ('project','document','code','coding');
$$;

-- ---------- RPCs ----------
-- codigo de convite com 10 chars hex (16^10 ~ 1,1 trilhao de combinacoes; os 6 antigos
-- eram enumeraveis, 16,7M). p_mode validado — antes qualquer string era aceita.
-- ---------- helpers de visibilidade (distribuicao / cego) ----------
-- CUIDADO (mesma classe do bug de shadowing que negou o bucket 'pdfs' inteiro): estas funcoes
-- comparam colunas homonimas (documents.id, projects.id, assignments.document_id) dentro de
-- subselects usados em POLICY. Por isso TODO parametro leva prefixo p_ e TODA tabela leva alias.

-- documento visivel? restricao desligada, ou admin, ou atribuido a mim.
-- Com restrict_docs LIGADO, documento SEM nenhuma atribuicao fica so com o admin (senao
-- sobraria um meio-estado ambiguo: corpus recem-importado aberto a todos ate ser distribuido).
create or replace function public.can_see_doc(p_project uuid, p_doc uuid)
returns boolean language sql security definer stable set search_path = public as $$
  select not coalesce((select pr.restrict_docs from public.projects pr where pr.id = p_project), false)
      or public.is_admin(p_project)
      or exists (select 1 from public.assignments a
                  where a.document_id = p_doc and a.user_id = auth.uid());
$$;

-- linha autoral visivel? cego desligado, ou admin, ou a linha e minha.
-- Vale para codings.created_by e doc_values.set_by. No cego a camada 'final' (gabarito, que o
-- admin carimba) TAMBEM sai da vista do membro, de proposito: revelar o gabarito no meio de um
-- estudo cego contamina a codificacao. Desligue o cego para liberar.
create or replace function public.can_see_authored(p_project uuid, p_owner uuid)
returns boolean language sql security definer stable set search_path = public as $$
  select not coalesce((select pr.blind from public.projects pr where pr.id = p_project), false)
      or public.is_admin(p_project)
      or p_owner = auth.uid();
$$;

-- memo visivel? os escopos que apontam para um documento ('document') ou para um trecho
-- ('coding', via a coding) herdam a visibilidade do ALVO; os demais (project, code, ai_*)
-- seguem abertos ao membro.
--
-- CORRIGIDO 29/jul: o escopo 'coding' herdava so o can_see_doc, e faltava o can_see_authored —
-- ou seja, sob CODIFICACAO CEGA o servidor escondia a coding alheia e MANDAVA a nota dela. A
-- nota analitica e o raciocinio do codificador, o dado que mais contamina um estudo cego, e o
-- cliente ainda a exibia: o MemoNav caia num fallback "(trecho removido)" que mostrava o inicio
-- do CONTEUDO como preview. Nao era vazamento silencioso, era vazamento legivel.
-- A regra agora e a MESMA da policy codings_select (documento E autor), que e o unico jeito de
-- os dois nao divergirem de novo: memo de trecho segue exatamente a visibilidade do trecho.
-- Efeito colateral aceito: memo ORFAO (coding inexistente) deixa de ser servido a qualquer um,
-- porque o `exists` da false quando nao ha linha. Orfao nao deveria existir (os triggers
-- memos_gc limpam nos cascades) e servir memo cujo alvo sumiu era justamente o que alimentava
-- aquele fallback do MemoNav.
create or replace function public.memo_visible(p_project uuid, p_scope text, p_target uuid)
returns boolean language sql security definer stable set search_path = public as $$
  select case
    when p_scope = 'document' then public.can_see_doc(p_project, p_target)
    when p_scope = 'coding'   then exists (
      select 1 from public.codings c
       where c.id = p_target
         and public.can_see_doc(p_project, c.document_id)
         and public.can_see_authored(p_project, c.created_by))
    else true
  end;
$$;

-- ---------- TRILHA DE AUDITORIA (S4, set/2026) ----------
-- Uma linha por OPERACAO que alterou o projeto (import, mesclagem, exclusao, aplicacao em lote,
-- consolidacao, mudanca de configuracao, export), nunca por linha de dado. A spec e a
-- to-do/spec-trilha-auditoria.md; o levantamento do campo esta no S9 do to-do (o NVivo manda
-- LIMPAR o log dele por desempenho, que e o preco de logar linha; o OpenQDA grava o texto do
-- trecho em old/new_values, que e um segundo canal do corpus).
-- APPEND-ONLY: sem policy de UPDATE nem de DELETE, e o grant e SO select+insert — o revoke abaixo
-- desfaz o que o ALTER DEFAULT PRIVILEGES do fim do arquivo (ou o do bootstrap do Supabase) deu a
-- tabela ao ser criada num banco que ja existia. Nao e prova forense: o operador do servidor
-- sempre pode. A trilha RELATA.
-- FORA da publicacao supabase_realtime de proposito (regra de ouro #11): evento nao e dado de
-- tela quente, e cada import dispararia recarga em todo mundo.
-- `detail` e jsonb com nomes e contagens, NUNCA texto do corpus (o cliente proibe `quote` e afins
-- antes de gravar — src/dados/trilha-de-auditoria.js); `target_name` e o nome CONGELADO no momento
-- do evento, para sobreviver a exclusao do alvo; `at` e o relogio do cliente (o que se exibe),
-- `created_at` o do servidor (o que ordena). `id` vem do cliente (replay idempotente na fila e
-- dedup por id na viagem pelo .qualilab); o default so serve ao log_activity.
create table if not exists public.activity (
  id          uuid primary key default gen_random_uuid(),
  project_id  uuid not null references public.projects(id) on delete cascade,
  op          text not null,
  target_kind text,
  target_id   uuid,
  target_name text,
  layer       text,
  detail      jsonb not null default '{}'::jsonb,
  actor       uuid,
  actor_name  text not null default 'anonimo',
  at          timestamptz not null default now(),
  created_at  timestamptz not null default now()
);
create index if not exists activity_project_idx on public.activity (project_id, created_at);
alter table public.activity enable row level security;
revoke all on public.activity from anon, authenticated;
grant select, insert on public.activity to authenticated;
-- VISIBILIDADE POR REUSO, sem predicado novo (spec §4): evento que aponta um documento passa pelo
-- can_see_doc (distribuicao restrita), e o AUTOR do evento passa pelo can_see_authored (cego) — os
-- dois eixos que os memos ja pagaram para aprender (gotcha 1b). Consequencia aceita: sob cego o
-- membro ve quase so os proprios eventos e o admin ve tudo; levantar o cego revela a trilha inteira,
-- porque a policy e lida em tempo de leitura sobre as flags atuais, como as codificacoes. Evento
-- IMPORTADO (actor null) segue o MESMO tratamento da codificacao importada sob cego (fica com o
-- admin) — e por isso nao ha clausula propria para layer='final': o can_see_authored ja a cobre.
-- Evento de EQUIPE (target_kind 'member') e visivel a todo membro sempre (decisao ⚑4 da spec):
-- quem entrou e saiu nao revela codificacao de ninguem.
drop policy if exists activity_select on public.activity;
create policy activity_select on public.activity for select using (
  public.is_member(project_id)
  and (
    target_kind = 'member'
    or (
      (target_kind is distinct from 'document' or target_id is null or public.can_see_doc(project_id, target_id))
      and public.can_see_authored(project_id, actor)
    )
  )
);
-- INSERT: cada um grava so como si mesmo; admin pode gravar ator livre (a trilha que vem num
-- .qualilab chega com actor null — a mesma excecao do created_by das codificacoes importadas).
-- is_member, e nao can_edit, de proposito: o viewer EXPORTA, e "dado saiu do projeto" e justamente o
-- evento que um comite de etica pergunta.
drop policy if exists activity_insert on public.activity;
create policy activity_insert on public.activity for insert with check (
  public.is_member(project_id) and (actor = auth.uid() or public.is_admin(project_id))
);
-- O que os RPCs de gestao gravam, dentro da PROPRIA transacao (cliente velho em cache, ou chamada
-- direta ao RPC, nao tem como pular). `trail_started` PREGUICOSO, o mesmo que o cliente faz: nasce
-- no primeiro evento de cada projeto, sem backfill (honestidade > completude retroativa).
-- NAO e chamavel por anon/authenticated (revoke abaixo): roda so de dentro dos RPCs security
-- definer, que executam como o dono do banco — a mesma regra das funcoes de trigger.
create or replace function public.log_activity(p_project uuid, p_op text, p_kind text, p_target uuid, p_name text, p_layer text, p_detail jsonb)
returns void language plpgsql security definer set search_path = public as $$
declare v_actor_name text;
begin
  select m.display_name into v_actor_name from public.members m where m.project_id = p_project and m.user_id = auth.uid();
  v_actor_name := coalesce(v_actor_name, 'anonimo');
  if p_op <> 'trail_started' and not exists (select 1 from public.activity a where a.project_id = p_project) then
    insert into public.activity (project_id, op, actor, actor_name) values (p_project, 'trail_started', auth.uid(), v_actor_name);
  end if;
  insert into public.activity (project_id, op, target_kind, target_id, target_name, layer, detail, actor, actor_name)
    values (p_project, p_op, p_kind, p_target, p_name, p_layer, coalesce(p_detail, '{}'::jsonb), auth.uid(), v_actor_name);
end; $$;
revoke execute on function public.log_activity(uuid,text,text,uuid,text,text,jsonb) from public, anon, authenticated;

-- ---------- ESPELHAR BASE (ponto de restauracao, set/2026) ----------
-- Um ESPELHO e o projeto inteiro num instante (o buildQualilabDb menos a trilha), que se pode
-- restaurar. Spec: to-do/spec-espelhar-base.md. O METADADO mora nesta tabela (listar sem baixar o
-- bucket); o RETRATO mora no bucket `snapshots`, objeto `<project_id>/<id>.json`. Membro le a lista;
-- so ADMIN cria e apaga (restaurar e destrutivo, e criar escreve no bucket). Sem UPDATE: um espelho
-- nao se edita, se apaga. As linhas cascateiam com o projeto; os objetos do bucket nao (o cliente
-- os remove best-effort antes do delete_project). FORA do realtime.
create table if not exists public.snapshots (
  id          uuid primary key,
  project_id  uuid not null references public.projects(id) on delete cascade,
  at          timestamptz not null default now(),
  reason      text not null default 'manual' check (reason in ('manual','auto')),
  before      text,
  label       text,
  size        bigint not null default 0,
  counts      jsonb not null default '{}'::jsonb,
  created_by  uuid,
  actor_name  text not null default 'anonimo',
  created_at  timestamptz not null default now()
);
create index if not exists snapshots_project_idx on public.snapshots (project_id, at desc);
alter table public.snapshots enable row level security;
revoke all on public.snapshots from anon, authenticated;
grant select, insert, delete on public.snapshots to authenticated;
drop policy if exists snapshots_select on public.snapshots;
create policy snapshots_select on public.snapshots for select using ( public.is_member(project_id) );
drop policy if exists snapshots_insert on public.snapshots;
create policy snapshots_insert on public.snapshots for insert with check ( public.is_admin(project_id) and created_by = auth.uid() );
drop policy if exists snapshots_delete on public.snapshots;
create policy snapshots_delete on public.snapshots for delete using ( public.is_admin(project_id) );
-- o bucket: privado; o primeiro segmento do nome e o project_id. Qualifique storage.objects.name
-- (gotcha #8 — 'name' cru dentro de um subselect com outra tabela liga na coluna errada).
insert into storage.buckets (id, name, public) values ('snapshots','snapshots',false) on conflict (id) do nothing;
drop policy if exists "snapshots_select" on storage.objects;
create policy "snapshots_select" on storage.objects for select to authenticated
  using ( bucket_id='snapshots' and public.is_member(split_part(storage.objects.name,'/',1)::uuid) );
drop policy if exists "snapshots_insert" on storage.objects;
create policy "snapshots_insert" on storage.objects for insert to authenticated
  with check ( bucket_id='snapshots' and public.is_admin(split_part(storage.objects.name,'/',1)::uuid) );
drop policy if exists "snapshots_update" on storage.objects;
create policy "snapshots_update" on storage.objects for update to authenticated
  using ( bucket_id='snapshots' and public.is_admin(split_part(storage.objects.name,'/',1)::uuid) );
drop policy if exists "snapshots_delete" on storage.objects;
create policy "snapshots_delete" on storage.objects for delete to authenticated
  using ( bucket_id='snapshots' and public.is_admin(split_part(storage.objects.name,'/',1)::uuid) );

-- ASSINATURA MUDOU (S7): parametro com default cria SOBRECARGA, nao substituicao — dai o drop.
-- O DEFAULT 'none' SERVE O CLIENTE VELHO, nao o novo. Cliente em cache nao tem a pergunta do t0,
-- e a UI dele mostra os paineis de IA: nascer 'all' ali pareceria app quebrado. O cliente novo
-- SEMPRE passa o valor escolhido — mesmo cuidado do p_mode, que quando faltava fazia projeto
-- individual nascer coletivo, calado.
drop function if exists public.create_project(text, text, text);
create or replace function public.create_project(p_name text, p_display text, p_mode text default 'collective', p_restrict_ai text default 'none')
returns public.projects language plpgsql security definer set search_path = public as $$
declare v_code text; v_proj public.projects;
begin
  v_code := upper(substr(replace(gen_random_uuid()::text,'-',''),1,10));
  insert into public.projects (name, code, mode, restrict_ai, created_by)
    values (coalesce(nullif(p_name,''),'Projeto'),
            v_code,
            case when p_mode in ('individual','collective') then p_mode else 'collective' end,
            case when p_restrict_ai in ('none','members','all') then p_restrict_ai else 'none' end,
            auth.uid())
    returning * into v_proj;
  insert into public.members (project_id, user_id, display_name, role)
    values (v_proj.id, auth.uid(), coalesce(nullif(p_display,''),'anonimo'), 'admin');
  return v_proj;
end; $$;

-- registro de tentativas de join com codigo invalido (throttle de enumeracao).
-- RLS ligada SEM policies: so as funcoes security definer escrevem/leem aqui.
create table if not exists public.join_attempts (
  user_id      uuid not null,
  attempted_at timestamptz not null default now()
);
create index if not exists join_attempts_user_idx on public.join_attempts (user_id, attempted_at);
alter table public.join_attempts enable row level security;
-- REVOGA o grant que o Supabase da por DEFAULT a toda tabela nova em public. A RLS ja nega
-- (esta ligada e sem policy nenhuma), entao isto e defesa em profundidade — e GRANT e RLS sao
-- camadas ORTOGONAIS, como o cabecalho do pgTAP 003 explica. Achado ao rodar a suite pela
-- primeira vez, em ago/2026: a assercao "join_attempts continua sem grant direto" era FALSA
-- no banco, e passava despercebida porque o arquivo nunca tinha chegado a executar.
revoke all on public.join_attempts from anon, authenticated;

-- ---------- CONVITES (papel fixado ANTES de entrar) ----------
-- Resolve "o admin quer travar o papel do convidado antes dele entrar" sem acrescentar
-- envio de e-mail pelo SERVIDOR: o convite e so um CODIGO — como o codigo generico do
-- projeto (linha acima, que ja funciona sem SMTP nenhum) — so que carrega um PAPEL, e
-- opcionalmente um E-MAIL, que trava quem pode resgatar. A entrega do codigo/link fica
-- por conta do admin (compartilha por fora do app; a UI oferece um mailto: que abre a
-- CAIXA DELE, nunca um envio pelo servidor — ver src/telas/hub-do-projeto.js).
create table if not exists public.project_invites (
  id           uuid primary key default gen_random_uuid(),
  project_id   uuid not null references public.projects(id) on delete cascade,
  code         text not null unique,
  role         text not null default 'member',   -- admin | member | viewer (mesma lista do set_member_role)
  email        text,                              -- null = convite generico (qualquer um com o codigo); preenchido = nominal
  created_by   uuid not null,
  created_at   timestamptz not null default now(),
  expires_at   timestamptz,
  max_uses     int not null default 1,
  use_count    int not null default 0,
  revoked_at   timestamptz
);
create index if not exists project_invites_project_idx on public.project_invites (project_id);
alter table public.project_invites enable row level security;
-- mesma defesa em profundidade do join_attempts, logo acima: RLS ligada SEM policy
-- nenhuma, e o grant que o Supabase da por padrao a toda tabela nova em public e revogado
-- explicitamente — so as RPCs security definer abaixo tocam esta tabela.
revoke all on public.project_invites from anon, authenticated;

-- IMPORTANTE (contrato com o front): codigo inexistente agora retorna NULL em vez de
-- raise — um raise desfaria a transacao inteira e apagaria o registro da tentativa,
-- inutilizando o throttle. O SupabaseStore.joinProject checa o null e monta a mensagem.
create or replace function public.join_project(p_code text, p_display text)
returns public.projects language plpgsql security definer set search_path = public as $$
declare v_proj public.projects; v_recent int; v_inv public.project_invites; v_existed boolean; v_who text;
begin
  v_who := coalesce(nullif(p_display,''),'anonimo');
  delete from public.join_attempts where attempted_at < now() - interval '1 day';
  select count(*) into v_recent from public.join_attempts
    where user_id = auth.uid() and attempted_at > now() - interval '1 hour';
  if v_recent >= 20 then
    raise exception 'Muitas tentativas com código inválido — aguarde e tente novamente mais tarde';
  end if;

  -- CONVITE tem PRECEDENCIA sobre o codigo generico do projeto: os codigos vivem em
  -- namespaces (tabelas) diferentes, entao testar os dois nao muda nada pra quem usa o
  -- codigo velho — so passa a reconhecer TAMBEM um codigo de convite.
  select * into v_inv from public.project_invites
    where code = upper(trim(p_code))
      and revoked_at is null
      and (expires_at is null or expires_at > now())
      and use_count < max_uses;
  if v_inv.id is not null then
    -- convite NOMINAL: so o e-mail declarado resgata. Quem tenta com outro e-mail recebe o
    -- MESMO contrato de "codigo invalido" do resto da funcao — nunca "existe um convite pra
    -- outro e-mail", que vazaria quem a pesquisa esta tentando recrutar.
    if v_inv.email is not null and lower(coalesce(auth.email(),'')) <> lower(v_inv.email) then
      insert into public.join_attempts (user_id) values (auth.uid());
      return null;
    end if;
    select * into v_proj from public.projects where id = v_inv.project_id;
    v_existed := exists (select 1 from public.members where project_id = v_proj.id and user_id = auth.uid());
    insert into public.members (project_id, user_id, display_name, role)
      values (v_proj.id, auth.uid(), v_who, v_inv.role)
      on conflict (project_id, user_id) do update set display_name = excluded.display_name;
    update public.project_invites set use_count = use_count + 1 where id = v_inv.id;
    -- TRILHA (S4): so quando a linha de members NASCE — este RPC roda a cada abertura do projeto
    if not v_existed then
      perform public.log_activity(v_proj.id, 'member_joined', 'member', auth.uid(), v_who, null, jsonb_build_object('who', v_who, 'role', v_inv.role));
    end if;
    return v_proj;
  end if;

  select * into v_proj from public.projects where code = upper(trim(p_code));
  if v_proj.id is null then
    insert into public.join_attempts (user_id) values (auth.uid());
    return null;
  end if;
  v_existed := exists (select 1 from public.members where project_id = v_proj.id and user_id = auth.uid());
  insert into public.members (project_id, user_id, display_name)
    values (v_proj.id, auth.uid(), v_who)
    on conflict (project_id, user_id) do update set display_name = excluded.display_name;
  if not v_existed then
    perform public.log_activity(v_proj.id, 'member_joined', 'member', auth.uid(), v_who, null, jsonb_build_object('who', v_who, 'role', 'member'));
  end if;
  return v_proj;
end; $$;

create or replace function public.create_invite(p_project uuid, p_role text, p_email text default null, p_max_uses int default 1, p_expires_hours int default null)
returns public.project_invites language plpgsql security definer set search_path = public as $$
declare v_code text; v_inv public.project_invites;
begin
  if not public.is_admin(p_project) then raise exception 'Apenas administradores podem criar convites'; end if;
  if p_role not in ('admin','member','viewer') then raise exception 'Papel inválido'; end if;
  v_code := upper(substr(replace(gen_random_uuid()::text,'-',''),1,10));
  insert into public.project_invites (project_id, code, role, email, created_by, max_uses, expires_at)
    values (p_project, v_code, p_role, nullif(trim(coalesce(p_email,'')),''), auth.uid(),
            greatest(coalesce(p_max_uses,1),1),
            case when p_expires_hours is not null then now() + (p_expires_hours || ' hours')::interval else null end)
    returning * into v_inv;
  return v_inv;
end; $$;

-- so lista pra quem e admin do projeto — nao raise (leitura vazia pra quem nao pode ver
-- e mais barato que exception, e a UI so chama isto com o botao ja escondido de non-admin).
create or replace function public.list_invites(p_project uuid)
returns setof public.project_invites language sql security definer stable set search_path = public as $$
  select * from public.project_invites
    where project_id = p_project and public.is_admin(p_project)
    order by created_at desc;
$$;

create or replace function public.revoke_invite(p_invite uuid)
returns void language plpgsql security definer set search_path = public as $$
declare v_pid uuid;
begin
  select project_id into v_pid from public.project_invites where id = p_invite;
  if v_pid is null or not public.is_admin(v_pid) then
    raise exception 'Apenas administradores podem revogar convites';
  end if;
  update public.project_invites set revoked_at = now() where id = p_invite;
end; $$;

drop function if exists public.my_projects();
create or replace function public.my_projects()
returns table (id uuid, name text, code text, mode text, role text,
               created_at timestamptz, n_documents bigint, n_codings bigint,
               blind boolean, restrict_docs boolean,
               restrict_ai text, ai_ever_enabled boolean)
language sql security definer stable set search_path = public as $$
  select p.id, p.name, p.code, p.mode,
    (select m.role from public.members m where m.project_id = p.id and m.user_id = auth.uid()) as role,
    p.created_at,
    (select count(*) from public.documents d where d.project_id = p.id),
    (select count(*) from public.codings  c where c.project_id = p.id),
    p.blind, p.restrict_docs, p.restrict_ai, p.ai_ever_enabled
  from public.projects p
  where exists (select 1 from public.members m where m.project_id = p.id and m.user_id = auth.uid())
  order by p.created_at desc;
$$;

create or replace function public.set_member_role(p_project uuid, p_user uuid, p_role text)
returns void language plpgsql security definer set search_path = public as $$
declare v_old text; v_who text;
begin
  if not public.is_admin(p_project) then raise exception 'Apenas administradores podem alterar papéis'; end if;
  if p_role not in ('admin','member','viewer') then raise exception 'Papel inválido'; end if;
  -- a guarda do ULTIMO ADMIN olha "deixa de ser admin", nao "vira member": presa ao literal
  -- 'member' ela deixaria promover o unico admin a viewer, e o projeto ficaria sem ninguem.
  if p_role <> 'admin'
     and exists (select 1 from public.members where project_id = p_project and user_id = p_user and role = 'admin')
     and (select count(*) from public.members where project_id = p_project and role = 'admin') <= 1
  then raise exception 'O projeto precisa de ao menos um administrador'; end if;
  select role, display_name into v_old, v_who from public.members where project_id = p_project and user_id = p_user;
  update public.members set role = p_role where project_id = p_project and user_id = p_user;
  -- TRILHA (S4): na mesma transacao, so quando mudou
  if v_old is not null and v_old is distinct from p_role then
    perform public.log_activity(p_project, 'role_changed', 'member', p_user, v_who, null, jsonb_build_object('who', v_who, 'from', v_old, 'to', p_role));
  end if;
end; $$;

create or replace function public.remove_member(p_project uuid, p_user uuid)
returns void language plpgsql security definer set search_path = public as $$
declare v_who text;
begin
  if p_user <> auth.uid() and not public.is_admin(p_project) then
    raise exception 'Apenas administradores podem remover outros membros';
  end if;
  if exists (select 1 from public.members where project_id = p_project and user_id = p_user and role = 'admin')
     and (select count(*) from public.members where project_id = p_project and role = 'admin') <= 1 then
    raise exception 'O projeto precisa de ao menos um administrador';
  end if;
  -- TRILHA (S4): antes do delete, porque o display_name mora na linha que vai sumir
  select display_name into v_who from public.members where project_id = p_project and user_id = p_user;
  if v_who is not null then
    perform public.log_activity(p_project, 'member_removed', 'member', p_user, v_who, null, jsonb_build_object('who', v_who, 'self', p_user = auth.uid()));
  end if;
  delete from public.members where project_id = p_project and user_id = p_user;
end; $$;

create or replace function public.rename_project(p_project uuid, p_name text)
returns void language plpgsql security definer set search_path = public as $$
declare v_old text;
begin
  if not public.is_admin(p_project) then raise exception 'Apenas administradores podem renomear o projeto'; end if;
  select name into v_old from public.projects where id = p_project;
  update public.projects set name = coalesce(nullif(p_name,''), name) where id = p_project;
  -- TRILHA (S4): na mesma transacao, so quando o nome de fato mudou
  if nullif(p_name,'') is not null and p_name is distinct from v_old then
    perform public.log_activity(p_project, 'project_renamed', 'project', p_project, p_name, null, jsonb_build_object('from', v_old, 'to', p_name));
  end if;
end; $$;

create or replace function public.delete_project(p_project uuid)
returns void language plpgsql security definer set search_path = public as $$
begin
  if not public.is_admin(p_project) then raise exception 'Apenas administradores podem excluir o projeto'; end if;
  delete from public.projects where id = p_project;
end; $$;

-- alterar o tipo do projeto (admin). Coletivo -> Individual colapsa tudo num único
-- codificador (camada final) e mantém só o gabarito das categorias.
create or replace function public.set_project_mode(p_project uuid, p_mode text, p_author text default 'pesquisador')
returns void language plpgsql security definer set search_path = public as $$
declare v_old text;
begin
  if not public.is_admin(p_project) then raise exception 'Apenas administradores podem alterar o tipo do projeto'; end if;
  if p_mode not in ('individual','collective') then raise exception 'Tipo inválido'; end if;
  select mode into v_old from public.projects where id = p_project;
  if p_mode = 'individual' then
    delete from public.codings c using public.codings keep
      where c.project_id = p_project and keep.project_id = p_project
        and c.document_id = keep.document_id and c.code_id = keep.code_id
        and c.span_start = keep.span_start and c.span_end = keep.span_end
        and c.ctid > keep.ctid;
    update public.codings set layer = 'final', created_by = auth.uid(), author_name = p_author
      where project_id = p_project;
    delete from public.doc_values where project_id = p_project and layer = 'individual';
    delete from public.doc_values d using public.doc_values keep
      where d.project_id = p_project and keep.project_id = p_project
        and d.layer = 'final' and keep.layer = 'final'
        and d.document_id = keep.document_id and d.category_id = keep.category_id
        and d.ctid > keep.ctid;
    update public.doc_values set set_by = auth.uid(), author_name = p_author
      where project_id = p_project and layer = 'final';
  end if;
  update public.projects set mode = p_mode where id = p_project;
  -- TRILHA (S4): na mesma transacao da conversao (que e destrutiva no sentido coletivo -> individual)
  if v_old is distinct from p_mode then
    perform public.log_activity(p_project, 'mode_changed', 'project', p_project, null, null, jsonb_build_object('from', v_old, 'to', p_mode));
  end if;
end; $$;

-- ligar/desligar distribuicao restritiva e cego (admin). Precisa de RPC porque projects
-- nao tem policy de UPDATE nenhuma -- so o select.
-- ASSINATURA MUDOU (S7) — drop antes, senao ficam DUAS funcoes e o PostgREST pode resolver a
-- ambiguidade para a errada. O grant tambem e por assinatura, e o drop leva o antigo junto.
drop function if exists public.set_project_flags(uuid,boolean,boolean);
-- ASSINATURA MUDOU DE NOVO (espelhar base, set/2026): + p_snapshots_auto. Cliente velho chama com os
-- quatro nomes e o quinto cai no default (null = nao mexe), entao nada quebra em cache.
drop function if exists public.set_project_flags(uuid,boolean,boolean,text);
create or replace function public.set_project_flags(p_project uuid, p_blind boolean default null, p_restrict boolean default null, p_restrict_ai text default null, p_snapshots_auto boolean default null)
returns public.projects language plpgsql security definer set search_path = public as $$
declare v_proj public.projects; v_old public.projects; v_detail jsonb := '{}'::jsonb;
begin
  if not public.is_admin(p_project) then
    raise exception 'Apenas administradores alteram a distribuicao, o modo cego e o acesso a IA';
  end if;
  select * into v_old from public.projects where id = p_project;
  update public.projects
     set blind         = coalesce(p_blind, blind),
         restrict_docs = coalesce(p_restrict, restrict_docs),
         -- null = nao mexe; valor fora da lista tambem nao (o check ja barraria, mas aqui a
         -- chamada parcial de blind/restrict nao pode falhar por causa de um terceiro campo)
         restrict_ai   = case when p_restrict_ai in ('none','members','all') then p_restrict_ai
                              else restrict_ai end,
         snapshots_auto = coalesce(p_snapshots_auto, snapshots_auto)
   where id = p_project
   returning * into v_proj;
  -- TRILHA (S4): so as chaves que MUDARAM, cada uma com de/para (aviso que nao corresponde a
  -- mudanca ensina a ignorar aviso — o mesmo criterio do resumo do import)
  if v_proj.blind is distinct from v_old.blind then
    v_detail := v_detail || jsonb_build_object('blind', jsonb_build_object('from', v_old.blind, 'to', v_proj.blind));
  end if;
  if v_proj.restrict_docs is distinct from v_old.restrict_docs then
    v_detail := v_detail || jsonb_build_object('restrict_docs', jsonb_build_object('from', v_old.restrict_docs, 'to', v_proj.restrict_docs));
  end if;
  if v_proj.restrict_ai is distinct from v_old.restrict_ai then
    v_detail := v_detail || jsonb_build_object('restrict_ai', jsonb_build_object('from', v_old.restrict_ai, 'to', v_proj.restrict_ai));
  end if;
  if v_proj.snapshots_auto is distinct from v_old.snapshots_auto then
    v_detail := v_detail || jsonb_build_object('snapshots_auto', jsonb_build_object('from', v_old.snapshots_auto, 'to', v_proj.snapshots_auto));
  end if;
  if v_detail <> '{}'::jsonb then
    perform public.log_activity(p_project, 'flags_changed', 'project', p_project, null, null, v_detail);
  end if;
  return v_proj;
end; $$;

grant execute on function public.create_project(text, text, text, text) to anon, authenticated;
grant execute on function public.join_project(text, text)         to anon, authenticated;
grant execute on function public.my_projects()                    to anon, authenticated;
grant execute on function public.is_admin(uuid)                   to anon, authenticated;
grant execute on function public.set_member_role(uuid,uuid,text)  to anon, authenticated;
grant execute on function public.remove_member(uuid,uuid)         to anon, authenticated;
grant execute on function public.rename_project(uuid,text)        to anon, authenticated;
grant execute on function public.delete_project(uuid)             to anon, authenticated;
grant execute on function public.set_project_mode(uuid,text,text) to anon, authenticated;
grant execute on function public.set_project_flags(uuid,boolean,boolean,text,boolean) to anon, authenticated;
grant execute on function public.create_invite(uuid,text,text,int,int) to anon, authenticated;
grant execute on function public.list_invites(uuid)                   to anon, authenticated;
grant execute on function public.revoke_invite(uuid)                  to anon, authenticated;
-- (issue #7) Os GRANTs de tabela ficam no FIM do arquivo, depois de TODAS as tabelas —
-- ver o bloco "GRANTS de tabela" no final.

-- ---------- RLS ----------
alter table public.projects   enable row level security;
alter table public.members    enable row level security;
alter table public.documents  enable row level security;
alter table public.categories enable row level security;
alter table public.doc_values enable row level security;
alter table public.codes      enable row level security;
alter table public.codings    enable row level security;
alter table public.assignments enable row level security;

drop policy if exists projects_select on public.projects;
create policy projects_select on public.projects for select using (public.is_member(id));

drop policy if exists members_select on public.members;
create policy members_select on public.members for select using (public.is_member(project_id));

-- documents: membro cria/le/renomeia; alterar o TEXTO e excluir sao admin. UPDATE fica
-- aberto (pro rename via Memos), mas o trigger documents_guard barra a troca de CONTEUDO
-- por nao-admin (editar o texto desloca os grifos de todos os codificadores — mesma regra
-- do gate canEditText). DELETE cascateia codings -> admin. (Antes: for all a qualquer membro.)
drop policy if exists documents_all    on public.documents;
drop policy if exists documents_select on public.documents;
drop policy if exists documents_insert on public.documents;
drop policy if exists documents_update on public.documents;
drop policy if exists documents_delete on public.documents;
create policy documents_select on public.documents for select
  using (public.is_member(project_id) and public.can_see_doc(project_id, id));
-- Com restrict_docs LIGADO, criar documento passa a ser ADMIN. Motivo (descoberto em teste):
-- addDocument faz INSERT ... RETURNING, e o Postgres aplica a policy de SELECT a linha
-- retornada. Documento nasce SEM atribuicao -> o proprio criador nao-admin nao passaria no
-- can_see_doc e o insert falharia ("new row violates row-level security policy"); e, se
-- passasse, o documento sumiria da tela dele no ato. Nao da pra consertar por trigger:
-- AFTER INSERT roda DEPOIS da projecao do RETURNING e BEFORE INSERT violaria a FK.
-- Sob distribuicao restritiva o corpus e do admin -- que e o fluxo que a restricao sustenta.
-- Projeto SEM restricao segue igual: qualquer membro adiciona documento.
create policy documents_insert on public.documents for insert with check (
  public.can_edit(project_id)
  and (public.is_admin(project_id)
       or not coalesce((select pr.restrict_docs from public.projects pr where pr.id = project_id), false))
);
create policy documents_update on public.documents for update
  using (public.can_edit(project_id) and public.can_see_doc(project_id, id))
  with check (public.can_edit(project_id) and public.can_see_doc(project_id, id));
create policy documents_delete on public.documents for delete using (public.is_admin(project_id));

create or replace function public.documents_guard()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  if TG_OP = 'UPDATE' and new.content is distinct from old.content
     and not public.is_admin(new.project_id) then
    raise exception 'Apenas administradores podem alterar o texto de um documento compartilhado';
  end if;
  return new;
end; $$;
revoke execute on function public.documents_guard() from public, anon, authenticated;
drop trigger if exists trg_documents_guard on public.documents;
create trigger trg_documents_guard before update on public.documents
  for each row execute function public.documents_guard();

-- codes: membro cria/edita (codificacao aberta renomeia/recolore o tempo todo); EXCLUIR e
-- admin (delete cascateia codings de todos). is_redaction protegido no trigger codes_color_guard.
drop policy if exists codes_all    on public.codes;
drop policy if exists codes_select on public.codes;
drop policy if exists codes_insert on public.codes;
drop policy if exists codes_update on public.codes;
drop policy if exists codes_delete on public.codes;
create policy codes_select on public.codes for select using (public.is_member(project_id));
create policy codes_insert on public.codes for insert with check (public.can_edit(project_id));
create policy codes_update on public.codes for update
  using (public.can_edit(project_id)) with check (public.can_edit(project_id));
create policy codes_delete on public.codes for delete using (public.is_admin(project_id));

-- codings: o servidor passa a ser a autoridade (antes uma unica policy for all deixava
-- qualquer membro forjar created_by, apagar codificacao alheia e escrever no gabarito).
--   - insert: cada um grava so como si mesmo (created_by = auth.uid()); admin pode inserir
--     com qualquer created_by (necessario pro import e pro merge de codigos, que recriam
--     codificacoes preservando o autor). Import e merge sao, portanto, admin em coletivo.
--   - camada 'final' (gabarito da Reconciliacao): so admin (removida a excecao created_by
--     null antiga, que deixava um membro forjar o gabarito por chamada direta).
--   - update/delete: dono da linha ou admin.
drop policy if exists codings_all    on public.codings;
drop policy if exists codings_select on public.codings;
drop policy if exists codings_insert on public.codings;
drop policy if exists codings_update on public.codings;
drop policy if exists codings_delete on public.codings;
-- DISTRIBUICAO/CEGO: esconder so o DOCUMENTO nao bastaria -- codings.quote carrega o TEXTO
-- do trecho, entao sem can_see_doc aqui o membro puxaria os trechos de um documento que nao
-- e dele direto pela API, sem nunca abrir o documento. A restricao vale tambem na ESCRITA
-- (nao adianta impedir de ler e deixar codificar).
create policy codings_select on public.codings for select using (
  public.is_member(project_id)
  and public.can_see_doc(project_id, document_id)
  and public.can_see_authored(project_id, created_by)
);
create policy codings_insert on public.codings for insert with check (
  public.can_edit(project_id)
  and public.can_see_doc(project_id, document_id)
  and (created_by = auth.uid() or public.is_admin(project_id))
  and (layer <> 'final' or public.is_admin(project_id))
);
create policy codings_update on public.codings for update
  using (public.can_edit(project_id) and public.can_see_doc(project_id, document_id)
         and (created_by = auth.uid() or public.is_admin(project_id)))
  with check (public.can_edit(project_id) and public.can_see_doc(project_id, document_id)
         and (created_by = auth.uid() or public.is_admin(project_id)));
create policy codings_delete on public.codings for delete
  using (public.can_edit(project_id) and public.can_see_doc(project_id, document_id)
         and (created_by = auth.uid() or public.is_admin(project_id)));

-- categorias: membros leem; apenas admins escrevem
drop policy if exists categories_all    on public.categories;
drop policy if exists categories_select on public.categories;
drop policy if exists categories_write  on public.categories;
create policy categories_select on public.categories for select using (public.is_member(project_id));
create policy categories_write  on public.categories for all
  using (public.is_admin(project_id)) with check (public.is_admin(project_id));

-- valores de categoria: membros leem; cada um escreve o seu; admin escreve o gabarito;
-- linhas importadas (set_by null) sao tratadas como um "pesquisador" separado, igual created_by
-- null em codings — o autor de fato fica em author_name, nao em set_by.
drop policy if exists doc_values_all      on public.doc_values;
drop policy if exists doc_values_select   on public.doc_values;
drop policy if exists doc_values_own      on public.doc_values;
drop policy if exists doc_values_final    on public.doc_values;
drop policy if exists doc_values_imported on public.doc_values;
create policy doc_values_select on public.doc_values for select using (
  public.is_member(project_id)
  and public.can_see_doc(project_id, document_id)
  and public.can_see_authored(project_id, set_by)
);
create policy doc_values_own on public.doc_values for all
  using (public.can_edit(project_id) and public.can_see_doc(project_id, document_id)
         and set_by = auth.uid() and layer = 'individual')
  with check (public.can_edit(project_id) and public.can_see_doc(project_id, document_id)
         and set_by = auth.uid() and layer = 'individual');
create policy doc_values_final on public.doc_values for all
  using (public.is_admin(project_id) and layer = 'final')
  with check (public.is_admin(project_id) and layer = 'final');
-- linhas importadas (set_by null): so admin insere/altera/apaga. O import passou a ser
-- admin em coletivo — antes qualquer membro inseria set_by null + author_name livre,
-- forjando a proveniencia de respostas "importadas".
drop policy if exists doc_values_imported_insert on public.doc_values;
drop policy if exists doc_values_imported_admin  on public.doc_values;
create policy doc_values_imported_admin on public.doc_values for all
  using (public.is_admin(project_id) and set_by is null and layer = 'individual')
  with check (public.is_admin(project_id) and set_by is null and layer = 'individual');

-- ---------- RLS: assignments (o plano de distribuicao) ----------
-- membro ve so a PROPRIA distribuicao (nao o plano inteiro do projeto); admin ve e escreve tudo.
drop policy if exists assignments_select on public.assignments;
drop policy if exists assignments_write  on public.assignments;
create policy assignments_select on public.assignments for select
  using (public.is_member(project_id) and (public.is_admin(project_id) or user_id = auth.uid()));
create policy assignments_write on public.assignments for all
  using (public.is_admin(project_id)) with check (public.is_admin(project_id));

-- ---------- RLS: storage (PDF original) ----------
-- Este bloco MOROU no topo (junto do create do bucket) ate jul/2026; desceu para ca porque
-- passou a depender de can_see_doc(). O PDF e a FONTE do texto: esconder o documento e deixar
-- o PDF acessivel vazaria o conteudo inteiro por outro caminho.
-- IMPORTANTE: qualifique storage.objects.name -- 'name' cru, dentro do subselect "from documents d",
-- liga em documents.name (o TITULO do doc), nao no nome do objeto -> a checagem nunca casava e a
-- RLS negava TODO upload/select do bucket (bug de shadowing, corrigido jul/2026; 0 objetos ate entao).
do $$ begin
  drop policy if exists "pdfs_select" on storage.objects;
  create policy "pdfs_select" on storage.objects for select to authenticated
    using ( bucket_id='pdfs' and exists (select 1 from public.documents d
      where d.id::text = split_part(storage.objects.name,'.',1)
        and public.is_member(d.project_id) and public.can_see_doc(d.project_id, d.id)) );
  drop policy if exists "pdfs_insert" on storage.objects;
  create policy "pdfs_insert" on storage.objects for insert to authenticated
    with check ( bucket_id='pdfs' and exists (select 1 from public.documents d
      where d.id::text = split_part(storage.objects.name,'.',1)
        and public.can_edit(d.project_id) and public.can_see_doc(d.project_id, d.id)) );
  drop policy if exists "pdfs_update" on storage.objects;
  create policy "pdfs_update" on storage.objects for update to authenticated
    using ( bucket_id='pdfs' and exists (select 1 from public.documents d
      where d.id::text = split_part(storage.objects.name,'.',1)
        and public.can_edit(d.project_id) and public.can_see_doc(d.project_id, d.id)) );
  drop policy if exists "pdfs_delete" on storage.objects;
  create policy "pdfs_delete" on storage.objects for delete to authenticated
    using ( bucket_id='pdfs' and exists (select 1 from public.documents d
      where d.id::text = split_part(storage.objects.name,'.',1)
        and public.can_edit(d.project_id) and public.can_see_doc(d.project_id, d.id)) );
end $$;

-- ---------- realtime ----------
do $$
declare t text;
begin
  foreach t in array array['codings','doc_values'] loop
    if not exists (
      select 1 from pg_publication_tables
      where pubname = 'supabase_realtime' and schemaname = 'public' and tablename = t
    ) then
      execute format('alter publication supabase_realtime add table public.%I;', t);
    end if;
  end loop;
end $$;

-- ---------- memos (nota unica compartilhada: projeto, documento, codigo ou trecho/coding) ----------
create table if not exists public.memos (
  id          uuid primary key default gen_random_uuid(),
  project_id  uuid not null references public.projects(id) on delete cascade,
  scope       text not null check (scope in ('project','document','code','coding','ai_context','ai_instructions','ai_stance','ai_stance_text','ai_prompt','ai_include_cats','ai_inject','cloud_stopwords')),
  target_id   uuid not null,  -- = project_id quando scope='project'; document_id/code_id/coding_id nos demais
  content     text not null default '',
  label       text not null default '',  -- nome do prompt salvo (scope='ai_prompt', biblioteca de prompts); '' nos demais
  author_name text not null default 'anonimo',
  updated_by  uuid,
  updated_at  timestamptz not null default now(),
  unique (project_id, scope, target_id)
);
-- migracao p/ bancos existentes: libera o escopo 'coding' (nota analitica por trecho — base da
-- "anotacao por trecho" / transparencia ativa). Idempotente: dropa o check antigo e recria.
-- escopos ai_* (jul/2026): config de IA por projeto (target_id = project_id):
--   ai_context = "Memo para a IA" (contexto do projeto injetado no prompt, opt-in por memo)
--   ai_instructions = instrucoes proprias a IA (entram no Papel e Principios)
--   ai_stance = postura de analise (guarda so o id: padrao|indutivo|dedutivo|abdutivo|personalizado)
--   ai_stance_text = texto da postura PERSONALIZADA (usado quando ai_stance='personalizado')
--   ai_prompt = prompt salvo na "biblioteca de prompts" (varios por projeto: target_id proprio; name em label)
--   ai_include_cats = toggle "Incluir categorias como metadados dos casos" (Analisar): content '1'=ligado, ''=desligado
--   ai_inject = selecao de memos injetados no prompt (Analisar): content = JSON array das chaves selecionadas
-- outros escopos de config por projeto (target_id = project_id):
--   cloud_stopwords = palavras ignoradas na nuvem de palavras (Graficos): content = JSON
--     {pt:bool, words:[...]} (pt = usar a lista padrao do portugues; palavra com '*' no fim e prefixo)
alter table public.memos add column if not exists label text not null default '';
alter table public.memos drop constraint if exists memos_scope_check;
alter table public.memos add constraint memos_scope_check check (scope in ('project','document','code','coding','ai_context','ai_instructions','ai_stance','ai_stance_text','ai_prompt','ai_include_cats','ai_inject','cloud_stopwords'));
alter table public.memos enable row level security;
-- nota UNICA compartilhada (co-editavel de proposito): nao travo quem edita, mas o servidor
-- carimba updated_by (trigger memos_provenance) pra a autoria da ultima edicao nao ser forjavel.
-- A POLICY UNICA `for all` VIROU DUAS por causa do viewer, e nao e cosmetico: em `for all` o
-- USING governa tambem o SELECT, entao exigir can_edit ali tiraria a LEITURA dele. Com uma
-- policy de SELECT propria (policies permissivas se somam em OR), a leitura fica intacta e so a
-- escrita ganha a condicao. O viewer escreve memo que e NOTA; config do estudo, nao.
drop policy if exists memos_all on public.memos;
drop policy if exists memos_select on public.memos;
drop policy if exists memos_write on public.memos;
create policy memos_select on public.memos for select
  using (public.is_member(project_id) and public.memo_visible(project_id, scope, target_id));
create policy memos_write on public.memos for all
  using (public.is_member(project_id) and public.memo_visible(project_id, scope, target_id)
         and (public.can_edit(project_id) or public.memo_is_note(scope)))
  with check (public.is_member(project_id) and public.memo_visible(project_id, scope, target_id)
         and (public.can_edit(project_id) or public.memo_is_note(scope)));
alter table public.memos add column if not exists updated_by uuid;
create or replace function public.memos_provenance()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  new.updated_by := auth.uid();
  return new;
end; $$;
revoke execute on function public.memos_provenance() from public, anon, authenticated;
drop trigger if exists trg_memos_provenance on public.memos;
create trigger trg_memos_provenance before insert or update on public.memos
  for each row execute function public.memos_provenance();

-- ---------- cor personalizada de codigo (somente nivel 0 / familia) ----------
alter table public.codes add column if not exists hue_deg int;
-- saturacao personalizada da familia (eixo vivo<->apagado, 35-75; null = padrao 58). Propaga aos
-- subcodigos igual ao hue_deg; NAO afeta luminosidade (profundidade). Mesmo gate de admin.
alter table public.codes add column if not exists sat int;

-- ---------- familia x codigo: DERIVADO, sem coluna ----------
-- Quem tem filhos e familia (agrupa, nao recebe trechos); quem nao tem recebe trechos. Chegou a
-- existir uma coluna is_family declarada na criacao; foi removida porque, com a conversao forcando
-- a decisao no momento em que um codigo ganha o primeiro filho, toda familia tem filhos por
-- construcao — o campo nunca poderia divergir da estrutura, so duplica-la (e divergir em silencio).
-- A regra vive no cliente: codigo com filhos some da lista de aplicar.

create or replace function public.codes_color_guard()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  -- so trava a cor de codigos de nivel 0 (familia); subcodigos sempre herdam, nunca escolhem
  if new.parent_id is null and not public.is_admin(new.project_id) then
    if (TG_OP = 'INSERT' and (new.hue_deg is not null or new.sat is not null))
       or (TG_OP = 'UPDATE' and (new.hue_deg is distinct from old.hue_deg
                                 or new.sat is distinct from old.sat)) then
      raise exception 'Apenas administradores podem definir a cor personalizada de uma família de código';
    end if;
  end if;
  -- censura (is_redaction, qualquer profundidade): so admin altera — protege a promessa de
  -- privacidade (senao um membro reexpoe trecho sensivel desmarcando a censura por UPDATE direto).
  if TG_OP = 'UPDATE' and new.is_redaction is distinct from old.is_redaction
     and not public.is_admin(new.project_id) then
    raise exception 'Apenas administradores podem alterar a censura de um código';
  end if;
  return new;
end; $$;
revoke execute on function public.codes_color_guard() from public, anon, authenticated;

drop trigger if exists trg_codes_color_guard on public.codes;
create trigger trg_codes_color_guard before insert or update on public.codes
  for each row execute function public.codes_color_guard();

-- S8: a proveniencia e IMUTAVEL depois do insert, e a trava vale para TODO MUNDO, admin incluso.
-- Nao e permissao, e invariante do dado: a linha nasce com a origem que teve, e nenhum caminho
-- legitimo do app muda esse campo depois (moveCodings troca code_id, o remap de edicao de texto
-- troca span/quote, e nenhum dos dois toca aqui). Sem a trava, "lavar" uma codificacao assistida
-- seria um UPDATE direto pela API — e o valor da coluna inteira e ser dificil de desmentir.
-- RAISE, e nao FORCE como no projects_ai_guard: la o valor e derivado e ninguem o escolhe; aqui
-- alguem esta escrevendo um valor diferente de proposito, e engolir isso em silencio esconderia
-- justamente o que a trava existe para tornar visivel.
create or replace function public.codings_source_guard()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  if new.source is distinct from old.source then
    raise exception 'A proveniencia de uma codificacao nao pode ser alterada depois de criada';
  end if;
  return new;
end; $$;
revoke execute on function public.codings_source_guard() from public, anon, authenticated;

drop trigger if exists trg_codings_source_guard on public.codings;
create trigger trg_codings_source_guard before update on public.codings
  for each row execute function public.codings_source_guard();

-- ---------- S7: quem pode usar a IA, e a trava de uma via ----------
-- can_use_ai responde a MESMA pergunta que a UI responde ao esconder os paineis, e existe para
-- que o servidor tambem a responda: "conversa de IA nao entra por este app" e verificavel aqui,
-- mesmo que "o pesquisador nao conversou" nunca seja.
create or replace function public.can_use_ai(p_project uuid)
returns boolean language sql stable security definer set search_path = public as $$
  select case (select restrict_ai from public.projects where id = p_project)
           when 'all'     then false
           when 'members' then public.is_admin(p_project)
           else true
         end;
$$;
-- can_use_ai roda DENTRO das policies de ia_results/ia_memory, e policy roda como o usuario
-- que chamou — sem este grant o insert falha por permissao da funcao, nao pela regra.
-- O GRANT MORA AQUI, colado na definicao, e nao no bloco de grants de RPC la em cima (corrigido
-- 02/set/2026): la ele vinha ~330 linhas ANTES da funcao existir, e o arquivo, que se promete
-- aplicavel de cima a baixo num banco novo, abortava em `function public.can_use_ai(uuid) does
-- not exist`. Passou despercebido porque nos dois Supabase a funcao ja existia de uma aplicacao
-- anterior; foi o pgTAP rodado num Postgres cru (scripts/pgtap-local.sh) que acusou.
grant execute on function public.can_use_ai(uuid) to anon, authenticated;

-- A trava e FORCADA aqui, e nao nos RPCs, de proposito: se quem a escrevesse fosse o cliente,
-- bastaria chamar o RPC direto pra contorna-la. FORCA em vez de RAISE porque isto e invariante
-- DERIVADA (o valor nao e escolha de ninguem), nao checagem de permissao — levantar excecao
-- quebraria update legitimo de outra coluna.
create or replace function public.projects_ai_guard()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  -- disponibilizar a IA a alguem (qualquer escopo que nao seja 'all') fica registrado...
  if new.restrict_ai is distinct from 'all' then
    new.ai_ever_enabled := true;
  end if;
  -- ...e o registro nao volta atras.
  if TG_OP = 'UPDATE' and old.ai_ever_enabled and not new.ai_ever_enabled then
    new.ai_ever_enabled := true;
  end if;
  return new;
end; $$;
revoke execute on function public.projects_ai_guard() from public, anon, authenticated;

drop trigger if exists trg_projects_ai_guard on public.projects;
create trigger trg_projects_ai_guard before insert or update on public.projects
  for each row execute function public.projects_ai_guard();
-- ---------- resultados salvos da aba "Analisar com IA" ----------
create table if not exists public.ia_results (
  id           uuid primary key default gen_random_uuid(),
  project_id   uuid not null references public.projects(id) on delete cascade,
  scope        text not null,        -- docs | codes | docs_codes
  mode_label   text not null,        -- rotulo da modalidade no momento da analise (ex.: "Insights")
  result       text not null,
  created_by   uuid,
  author_name  text not null default 'anonimo',
  created_at   timestamptz not null default now()
);
alter table public.ia_results enable row level security;
-- proveniencia confiavel (espelha ia_memory): insere so como si mesmo (ou null legado);
-- edita/apaga so o autor ou admin — antes um for all deixava reescrever/apagar resultado
-- alheio e forjar created_by/author_name.
drop policy if exists ia_results_all    on public.ia_results;
drop policy if exists ia_results_select on public.ia_results;
drop policy if exists ia_results_insert on public.ia_results;
drop policy if exists ia_results_update on public.ia_results;
drop policy if exists ia_results_delete on public.ia_results;
create policy ia_results_select on public.ia_results for select using (public.is_member(project_id));
-- can_use_ai (S7): conversa nao entra em projeto cujo escopo fechou a IA pra quem esta gravando.
-- MORDE O IMPORT de proposito, e o cliente TEM de nomear o motivo no resumo: o mergeQualilabDb
-- grava por addIaResultsBulk, entao um .qualilab com historico entrando num projeto 'all' vira
-- linha recusada — numero sem motivo passa por bug.
create policy ia_results_insert on public.ia_results for insert
  with check (public.can_edit(project_id) and (created_by = auth.uid() or created_by is null)
              and public.can_use_ai(project_id));
create policy ia_results_update on public.ia_results for update
  using (public.can_edit(project_id) and (created_by = auth.uid() or public.is_admin(project_id)))
  with check (public.can_edit(project_id) and (created_by = auth.uid() or public.is_admin(project_id)));
create policy ia_results_delete on public.ia_results for delete
  using (public.can_edit(project_id) and (created_by = auth.uid() or public.is_admin(project_id)));

-- ---------- diario de insights da IA: memoria persistente e curada do projeto ----------
-- Lista de memorias curtas (fatos/decisoes/insights) que a IA propoe e o pesquisador
-- aprova; as ativas sao injetadas no system prompt das chamadas de IA. 1-para-muitos por
-- projeto (igual ia_results), nao upsert. active = entra no prompt (escolha do pesquisador,
-- por economia/transparencia). ai_model = proveniencia (qual modelo gerou); '' = manual.
create table if not exists public.ia_memory (
  id           uuid primary key default gen_random_uuid(),
  project_id   uuid not null references public.projects(id) on delete cascade,
  content      text not null,
  reason       text not null default '',
  source       text not null default 'ai',   -- 'ai' (proposta aprovada) | 'manual'
  active       boolean not null default true, -- entra no prompt? (pesquisador escolhe)
  ai_model     text not null default '',      -- modelo que autorou (proveniencia); '' = manual
  mode_label   text not null default '',      -- contexto que originou (opcional)
  created_by   uuid,                          -- membro que gerou/aprovou (auditoria em coletivo)
  author_name  text not null default 'anonimo',
  created_at   timestamptz not null default now()
);
alter table public.ia_memory enable row level security;
-- proveniencia (created_by/ai_model) e AUDITORIA em coletivo — por isso o update direto
-- e restrito ao autor/admin (antes qualquer membro podia reescrever o content de uma
-- memoria alheia mantendo a proveniencia antiga, falsificando a auditoria). O toggle
-- de "usar na analise" (active) continua aberto a todo membro, via RPC dedicada abaixo.
-- delete segue aberto a membros: curadoria coletiva; apagar e visivel, nao falsifica.
drop policy if exists ia_memory_all    on public.ia_memory;
drop policy if exists ia_memory_select on public.ia_memory;
drop policy if exists ia_memory_insert on public.ia_memory;
drop policy if exists ia_memory_update on public.ia_memory;
drop policy if exists ia_memory_delete on public.ia_memory;
create policy ia_memory_select on public.ia_memory for select using (public.is_member(project_id));
create policy ia_memory_insert on public.ia_memory for insert
  with check (public.can_edit(project_id) and (created_by = auth.uid() or created_by is null)
              and public.can_use_ai(project_id));
create policy ia_memory_update on public.ia_memory for update
  using (public.can_edit(project_id) and (created_by = auth.uid() or public.is_admin(project_id)))
  with check (public.can_edit(project_id) and (created_by = auth.uid() or public.is_admin(project_id)));
create policy ia_memory_delete on public.ia_memory for delete
  using (public.can_edit(project_id));

-- toggle de active aberto a qualquer membro (a policy de update acima nao cobre
-- memoria alheia de proposito); o SupabaseStore.setMemoryActive chama esta RPC.
create or replace function public.set_memory_active(p_id uuid, p_active boolean)
returns void language plpgsql security definer set search_path = public as $$
declare v_pid uuid;
begin
  select project_id into v_pid from public.ia_memory where id = p_id;
  if v_pid is null then raise exception 'Memória não encontrada'; end if;
  -- o gate vai AQUI e nao so na policy: a RPC e security definer, entao sem ele ela seria a
  -- porta de fuga do viewer para o toggle de "usar na análise".
  if not public.can_edit(v_pid) then raise exception 'Somente leitura: este papel não altera a memória do projeto'; end if;
  update public.ia_memory set active = p_active where id = p_id;
end; $$;
grant execute on function public.set_memory_active(uuid, boolean) to anon, authenticated;

-- ---------- ai_prices (referencia de preco por modelo — "calculadora de custo" da IA) ----------
-- Preco de LISTA por 1M de tokens, so pra estimar o custo das chamadas de IA em US$/R$. Leitura
-- PUBLICA (preco de lista nao e segredo; o front le pra estimar antes/depois da chamada); escrita
-- so por service_role via SQL (anon/authenticated NAO alteram — sem policy de insert/update/delete).
-- Fonte dos valores: paginas oficiais de pricing (Anthropic jun/2026; OpenAI e Gemini jul/2026,
-- tier padrao/short-context <=200k). Confira periodicamente e ajuste com UPDATE.
-- Atualizar preco = UPDATE aqui (nao mexe no codigo, nao precisa deploy). BYOK: o pesquisador pode
-- sobrescrever com a tarifa dele em "Minha Conta" (localStorage), e isso vence esta referencia.
create table if not exists public.ai_prices (
  provider       text not null,   -- gemini | openai | anthropic
  model          text not null,   -- id do modelo (bate com AI_PROVIDERS no front-end)
  input_usd_1m   numeric not null default 0,   -- US$ por 1.000.000 de tokens de ENTRADA
  output_usd_1m  numeric not null default 0,   -- US$ por 1.000.000 de tokens de SAIDA
  updated_at     timestamptz not null default now(),
  primary key (provider, model)
);
alter table public.ai_prices enable row level security;
drop policy if exists ai_prices_read on public.ai_prices;
create policy ai_prices_read on public.ai_prices for select using (true);
-- seed inicial (idempotente: on conflict DO NOTHING preserva correcoes feitas depois via UPDATE).
insert into public.ai_prices (provider, model, input_usd_1m, output_usd_1m) values
  -- catálogo atual (bate com AI_PROVIDERS no front)
  ('anthropic', 'claude-haiku-4-5',        1.00,  5.00),   -- Anthropic oficial (jun/2026)
  ('anthropic', 'claude-sonnet-5',         3.00, 15.00),   -- padrão (standard; intro $2/$10 até 31/08/2026)
  ('anthropic', 'claude-opus-4-8',         5.00, 25.00),
  ('openai',    'gpt-5.6-luna',            1.00,  6.00),   -- OpenAI short-context (jul/2026)
  ('openai',    'gpt-5.6-terra',           2.50, 15.00),   -- padrão
  ('openai',    'gpt-5.6-sol',             5.00, 30.00),
  ('gemini',    'gemini-3.1-flash-lite',   0.25,  1.50),   -- Gemini paid, prompts <=200k (jul/2026)
  ('gemini',    'gemini-3.5-flash',        1.50,  9.00),   -- padrão
  ('gemini',    'gemini-3.1-pro-preview',  2.00, 12.00),
  -- legado (fora do catálogo do front, mantidos p/ configs antigas salvas no navegador)
  ('anthropic', 'claude-sonnet-4-6',       3.00, 15.00),
  ('openai',    'gpt-5.4-mini',            0.75,  4.50),
  ('openai',    'gpt-5.4',                 2.50, 15.00),
  ('openai',    'gpt-5.5',                 5.00, 30.00)
on conflict (provider, model) do nothing;

-- ---------- limpeza de memos orfaos no proprio banco ----------
-- memos.target_id nao tem FK (aponta pra tabelas diferentes conforme o scope), entao o
-- Postgres nao limpa sozinho. Os stores do cliente ja limpam nos fluxos do app, mas as
-- CASCATAS do proprio banco (ex.: deletar documento apaga codings em cascata) deixavam
-- orfaos os memos de coding/subcodigo. Triggers AFTER DELETE cobrem tudo, inclusive as
-- linhas apagadas por cascade.
create or replace function public.memos_gc()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  delete from public.memos where scope = TG_ARGV[0] and target_id = old.id;
  return old;
end; $$;
revoke execute on function public.memos_gc() from public, anon, authenticated;
drop trigger if exists trg_memos_gc_documents on public.documents;
create trigger trg_memos_gc_documents after delete on public.documents
  for each row execute function public.memos_gc('document');
drop trigger if exists trg_memos_gc_codes on public.codes;
create trigger trg_memos_gc_codes after delete on public.codes
  for each row execute function public.memos_gc('code');
drop trigger if exists trg_memos_gc_codings on public.codings;
create trigger trg_memos_gc_codings after delete on public.codings
  for each row execute function public.memos_gc('coding');

-- tirar um membro do projeto tira junto a distribuicao dele (assignments.user_id e um uuid
-- solto, sem FK para members -- entao a limpeza nao vem de cascade).
create or replace function public.assignments_gc()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  delete from public.assignments where project_id = old.project_id and user_id = old.user_id;
  return old;
end; $$;
revoke execute on function public.assignments_gc() from public, anon, authenticated;
drop trigger if exists trg_assignments_gc on public.members;
create trigger trg_assignments_gc after delete on public.members
  for each row execute function public.assignments_gc();

-- ---------- GRANTS de tabela (issue #7 — portabilidade/autocontencao) ----------
-- FICAM NO FIM DE PROPOSITO: referenciam TODAS as tabelas (memos/ia_results/ia_memory/
-- ai_prices sao criadas acima), entao rodar o schema.sql inteiro num banco NOVO nao falha
-- com "relation does not exist". GRANT e RLS sao camadas ORTOGONAIS: o grant nao enfraquece
-- a RLS (que decide linha a linha). No Supabase hospedado o ALTER DEFAULT PRIVILEGES do
-- bootstrap ja concede ALL a anon/authenticated; este bloco torna o schema AUTOCONTIDO
-- para stacks novas / self-hosted onde esse mecanismo nao existe.
grant usage on schema public to anon, authenticated;
grant select, insert, update, delete on
  public.projects, public.members, public.documents, public.categories,
  public.doc_values, public.codes, public.codings, public.assignments,
  public.memos, public.ia_results, public.ia_memory
  to authenticated;
-- activity (trilha de auditoria) fica FORA desta lista de proposito: e append-only, e o grant dela
-- (so select+insert) e dado logo depois do create, na secao da trilha. `snapshots` idem: sem
-- update (select+insert+delete), grant dado na secao do espelhar base.
-- ai_prices: leitura publica (preco de lista nao e segredo); escrita so service_role.
-- O ALTER DEFAULT PRIVILEGES abaixo roda DEPOIS do create de ai_prices, entao NAO concede
-- escrita a ela (default privileges so valem para tabelas criadas APOS o statement).
grant select on public.ai_prices to anon, authenticated;
-- join_attempts NAO recebe grant direto: so a RPC security-definer join_project a toca.
-- project_invites idem: so create_invite/list_invites/revoke_invite/join_project a tocam.
-- Alinha tabelas FUTURAS (proximas migracoes) ao mesmo contrato (idempotente).
alter default privileges in schema public
  grant select, insert, update, delete on tables to authenticated;
