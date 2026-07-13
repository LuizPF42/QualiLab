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

create table if not exists public.members (
  id           uuid primary key default gen_random_uuid(),
  project_id   uuid not null references public.projects(id) on delete cascade,
  user_id      uuid not null,
  display_name text not null default 'anonimo',
  role         text not null default 'member',   -- admin | member
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

create table if not exists public.categories (
  id          uuid primary key default gen_random_uuid(),
  project_id  uuid not null references public.projects(id) on delete cascade,
  name        text not null,
  kind        text not null default 'single',     -- single | text | select | date | checkbox
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
  created_at   timestamptz not null default now()
);
alter table public.codings add column if not exists layer text not null default 'individual';

-- ---------- funções de pertencimento ----------
create or replace function public.is_member(p uuid)
returns boolean language sql security definer stable set search_path = public as $$
  select exists (select 1 from public.members where project_id = p and user_id = auth.uid());
$$;

create or replace function public.is_admin(p uuid)
returns boolean language sql security definer stable set search_path = public as $$
  select exists (select 1 from public.members where project_id = p and user_id = auth.uid() and role = 'admin');
$$;

-- ---------- RPCs ----------
-- codigo de convite com 10 chars hex (16^10 ~ 1,1 trilhao de combinacoes; os 6 antigos
-- eram enumeraveis, 16,7M). p_mode validado — antes qualquer string era aceita.
create or replace function public.create_project(p_name text, p_display text, p_mode text default 'collective')
returns public.projects language plpgsql security definer set search_path = public as $$
declare v_code text; v_proj public.projects;
begin
  v_code := upper(substr(replace(gen_random_uuid()::text,'-',''),1,10));
  insert into public.projects (name, code, mode, created_by)
    values (coalesce(nullif(p_name,''),'Projeto'),
            v_code,
            case when p_mode in ('individual','collective') then p_mode else 'collective' end,
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

-- IMPORTANTE (contrato com o front): codigo inexistente agora retorna NULL em vez de
-- raise — um raise desfaria a transacao inteira e apagaria o registro da tentativa,
-- inutilizando o throttle. O SupabaseStore.joinProject checa o null e monta a mensagem.
create or replace function public.join_project(p_code text, p_display text)
returns public.projects language plpgsql security definer set search_path = public as $$
declare v_proj public.projects; v_recent int;
begin
  delete from public.join_attempts where attempted_at < now() - interval '1 day';
  select count(*) into v_recent from public.join_attempts
    where user_id = auth.uid() and attempted_at > now() - interval '1 hour';
  if v_recent >= 20 then
    raise exception 'Muitas tentativas com código inválido — aguarde e tente novamente mais tarde';
  end if;
  select * into v_proj from public.projects where code = upper(trim(p_code));
  if v_proj.id is null then
    insert into public.join_attempts (user_id) values (auth.uid());
    return null;
  end if;
  insert into public.members (project_id, user_id, display_name)
    values (v_proj.id, auth.uid(), coalesce(nullif(p_display,''),'anonimo'))
    on conflict (project_id, user_id) do update set display_name = excluded.display_name;
  return v_proj;
end; $$;

drop function if exists public.my_projects();
create or replace function public.my_projects()
returns table (id uuid, name text, code text, mode text, role text,
               created_at timestamptz, n_documents bigint, n_codings bigint)
language sql security definer stable set search_path = public as $$
  select p.id, p.name, p.code, p.mode,
    (select m.role from public.members m where m.project_id = p.id and m.user_id = auth.uid()) as role,
    p.created_at,
    (select count(*) from public.documents d where d.project_id = p.id),
    (select count(*) from public.codings  c where c.project_id = p.id)
  from public.projects p
  where exists (select 1 from public.members m where m.project_id = p.id and m.user_id = auth.uid())
  order by p.created_at desc;
$$;

create or replace function public.set_member_role(p_project uuid, p_user uuid, p_role text)
returns void language plpgsql security definer set search_path = public as $$
begin
  if not public.is_admin(p_project) then raise exception 'Apenas administradores podem alterar papéis'; end if;
  if p_role not in ('admin','member') then raise exception 'Papel inválido'; end if;
  if p_role = 'member'
     and exists (select 1 from public.members where project_id = p_project and user_id = p_user and role = 'admin')
     and (select count(*) from public.members where project_id = p_project and role = 'admin') <= 1
  then raise exception 'O projeto precisa de ao menos um administrador'; end if;
  update public.members set role = p_role where project_id = p_project and user_id = p_user;
end; $$;

create or replace function public.remove_member(p_project uuid, p_user uuid)
returns void language plpgsql security definer set search_path = public as $$
begin
  if p_user <> auth.uid() and not public.is_admin(p_project) then
    raise exception 'Apenas administradores podem remover outros membros';
  end if;
  if exists (select 1 from public.members where project_id = p_project and user_id = p_user and role = 'admin')
     and (select count(*) from public.members where project_id = p_project and role = 'admin') <= 1 then
    raise exception 'O projeto precisa de ao menos um administrador';
  end if;
  delete from public.members where project_id = p_project and user_id = p_user;
end; $$;

create or replace function public.rename_project(p_project uuid, p_name text)
returns void language plpgsql security definer set search_path = public as $$
begin
  if not public.is_admin(p_project) then raise exception 'Apenas administradores podem renomear o projeto'; end if;
  update public.projects set name = coalesce(nullif(p_name,''), name) where id = p_project;
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
begin
  if not public.is_admin(p_project) then raise exception 'Apenas administradores podem alterar o tipo do projeto'; end if;
  if p_mode not in ('individual','collective') then raise exception 'Tipo inválido'; end if;
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
end; $$;

grant execute on function public.create_project(text, text, text) to anon, authenticated;
grant execute on function public.join_project(text, text)         to anon, authenticated;
grant execute on function public.my_projects()                    to anon, authenticated;
grant execute on function public.is_admin(uuid)                   to anon, authenticated;
grant execute on function public.set_member_role(uuid,uuid,text)  to anon, authenticated;
grant execute on function public.remove_member(uuid,uuid)         to anon, authenticated;
grant execute on function public.rename_project(uuid,text)        to anon, authenticated;
grant execute on function public.delete_project(uuid)             to anon, authenticated;
grant execute on function public.set_project_mode(uuid,text,text) to anon, authenticated;

-- ---------- RLS ----------
alter table public.projects   enable row level security;
alter table public.members    enable row level security;
alter table public.documents  enable row level security;
alter table public.categories enable row level security;
alter table public.doc_values enable row level security;
alter table public.codes      enable row level security;
alter table public.codings    enable row level security;

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
create policy documents_select on public.documents for select using (public.is_member(project_id));
create policy documents_insert on public.documents for insert with check (public.is_member(project_id));
create policy documents_update on public.documents for update
  using (public.is_member(project_id)) with check (public.is_member(project_id));
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
create policy codes_insert on public.codes for insert with check (public.is_member(project_id));
create policy codes_update on public.codes for update
  using (public.is_member(project_id)) with check (public.is_member(project_id));
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
create policy codings_select on public.codings for select using (public.is_member(project_id));
create policy codings_insert on public.codings for insert with check (
  public.is_member(project_id)
  and (created_by = auth.uid() or public.is_admin(project_id))
  and (layer <> 'final' or public.is_admin(project_id))
);
create policy codings_update on public.codings for update
  using (public.is_member(project_id) and (created_by = auth.uid() or public.is_admin(project_id)))
  with check (public.is_member(project_id) and (created_by = auth.uid() or public.is_admin(project_id)));
create policy codings_delete on public.codings for delete
  using (public.is_member(project_id) and (created_by = auth.uid() or public.is_admin(project_id)));

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
create policy doc_values_select on public.doc_values for select using (public.is_member(project_id));
create policy doc_values_own on public.doc_values for all
  using (public.is_member(project_id) and set_by = auth.uid() and layer = 'individual')
  with check (public.is_member(project_id) and set_by = auth.uid() and layer = 'individual');
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
  scope       text not null check (scope in ('project','document','code','coding','ai_context','ai_instructions','ai_stance','ai_stance_text','ai_prompt','ai_include_cats','ai_inject')),
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
alter table public.memos add column if not exists label text not null default '';
alter table public.memos drop constraint if exists memos_scope_check;
alter table public.memos add constraint memos_scope_check check (scope in ('project','document','code','coding','ai_context','ai_instructions','ai_stance','ai_stance_text','ai_prompt','ai_include_cats','ai_inject'));
alter table public.memos enable row level security;
-- nota UNICA compartilhada (co-editavel de proposito): nao travo quem edita, mas o servidor
-- carimba updated_by (trigger memos_provenance) pra a autoria da ultima edicao nao ser forjavel.
drop policy if exists memos_all on public.memos;
create policy memos_all on public.memos for all
  using (public.is_member(project_id)) with check (public.is_member(project_id));
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

create or replace function public.codes_color_guard()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  -- so trava a cor de codigos de nivel 0 (familia); subcodigos sempre herdam, nunca escolhem
  if new.parent_id is null and not public.is_admin(new.project_id) then
    if (TG_OP = 'INSERT' and new.hue_deg is not null)
       or (TG_OP = 'UPDATE' and new.hue_deg is distinct from old.hue_deg) then
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
create policy ia_results_insert on public.ia_results for insert
  with check (public.is_member(project_id) and (created_by = auth.uid() or created_by is null));
create policy ia_results_update on public.ia_results for update
  using (public.is_member(project_id) and (created_by = auth.uid() or public.is_admin(project_id)))
  with check (public.is_member(project_id) and (created_by = auth.uid() or public.is_admin(project_id)));
create policy ia_results_delete on public.ia_results for delete
  using (public.is_member(project_id) and (created_by = auth.uid() or public.is_admin(project_id)));

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
  with check (public.is_member(project_id) and (created_by = auth.uid() or created_by is null));
create policy ia_memory_update on public.ia_memory for update
  using (public.is_member(project_id) and (created_by = auth.uid() or public.is_admin(project_id)))
  with check (public.is_member(project_id) and (created_by = auth.uid() or public.is_admin(project_id)));
create policy ia_memory_delete on public.ia_memory for delete
  using (public.is_member(project_id));

-- toggle de active aberto a qualquer membro (a policy de update acima nao cobre
-- memoria alheia de proposito); o SupabaseStore.setMemoryActive chama esta RPC.
create or replace function public.set_memory_active(p_id uuid, p_active boolean)
returns void language plpgsql security definer set search_path = public as $$
declare v_pid uuid;
begin
  select project_id into v_pid from public.ia_memory where id = p_id;
  if v_pid is null then raise exception 'Memória não encontrada'; end if;
  if not public.is_member(v_pid) then raise exception 'Apenas membros do projeto podem alterar a memória'; end if;
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
