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
  position    int  not null default 0
);

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
create or replace function public.create_project(p_name text, p_display text, p_mode text default 'collective')
returns public.projects language plpgsql security definer set search_path = public as $$
declare v_code text; v_proj public.projects;
begin
  v_code := upper(substr(replace(gen_random_uuid()::text,'-',''),1,6));
  insert into public.projects (name, code, mode, created_by)
    values (coalesce(nullif(p_name,''),'Projeto'), v_code, coalesce(nullif(p_mode,''),'collective'), auth.uid())
    returning * into v_proj;
  insert into public.members (project_id, user_id, display_name, role)
    values (v_proj.id, auth.uid(), coalesce(nullif(p_display,''),'anonimo'), 'admin');
  return v_proj;
end; $$;

create or replace function public.join_project(p_code text, p_display text)
returns public.projects language plpgsql security definer set search_path = public as $$
declare v_proj public.projects;
begin
  select * into v_proj from public.projects where code = upper(trim(p_code));
  if v_proj.id is null then
    raise exception 'Projeto não encontrado para o código %', p_code;
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

do $$
declare t text;
begin
  foreach t in array array['documents','codes','codings'] loop
    execute format('drop policy if exists %1$s_all on public.%1$s;', t);
    execute format(
      'create policy %1$s_all on public.%1$s for all
         using (public.is_member(project_id)) with check (public.is_member(project_id));', t);
  end loop;
end $$;

-- categorias: membros leem; apenas admins escrevem
drop policy if exists categories_all    on public.categories;
drop policy if exists categories_select on public.categories;
drop policy if exists categories_write  on public.categories;
create policy categories_select on public.categories for select using (public.is_member(project_id));
create policy categories_write  on public.categories for all
  using (public.is_admin(project_id)) with check (public.is_admin(project_id));

-- valores de categoria: membros leem; cada um escreve o seu; admin escreve o gabarito
drop policy if exists doc_values_all    on public.doc_values;
drop policy if exists doc_values_select on public.doc_values;
drop policy if exists doc_values_own    on public.doc_values;
drop policy if exists doc_values_final  on public.doc_values;
create policy doc_values_select on public.doc_values for select using (public.is_member(project_id));
create policy doc_values_own on public.doc_values for all
  using (public.is_member(project_id) and set_by = auth.uid() and layer = 'individual')
  with check (public.is_member(project_id) and set_by = auth.uid() and layer = 'individual');
create policy doc_values_final on public.doc_values for all
  using (public.is_admin(project_id) and layer = 'final')
  with check (public.is_admin(project_id) and layer = 'final');

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

-- ---------- memos (nota unica compartilhada: projeto, documento ou codigo) ----------
create table if not exists public.memos (
  id          uuid primary key default gen_random_uuid(),
  project_id  uuid not null references public.projects(id) on delete cascade,
  scope       text not null check (scope in ('project','document','code')),
  target_id   uuid not null,  -- = project_id quando scope='project'; document_id ou code_id nos demais
  content     text not null default '',
  author_name text not null default 'anonimo',
  updated_by  uuid,
  updated_at  timestamptz not null default now(),
  unique (project_id, scope, target_id)
);
alter table public.memos enable row level security;
drop policy if exists memos_all on public.memos;
create policy memos_all on public.memos for all
  using (public.is_member(project_id)) with check (public.is_member(project_id));

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
  return new;
end; $$;

drop trigger if exists trg_codes_color_guard on public.codes;
create trigger trg_codes_color_guard before insert or update on public.codes
  for each row execute function public.codes_color_guard();
