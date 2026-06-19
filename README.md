# QualiLab

**o seu laboratório de pesquisa qualitativa / your own lab for qualitative research**

QualiLab é uma ferramenta de **análise qualitativa de dados** (codificação de textos) que roda inteira em um único arquivo `index.html`. Permite enviar documentos, codificar trechos com uma árvore hierárquica de códigos, descrever atributos por documento e exportar tudo em formatos abertos — sozinho (modo local) ou em equipe (modo nuvem, com Supabase).

> Inspirado em ferramentas como ATLAS.ti, MAXQDA, NVivo e Taguette, mas leve, gratuito e sem instalação.

---

## Recursos

- **Documentos**: envie `.txt`, `.md`, `.docx`, `.pdf` ou cole texto. O conteúdo é extraído e exibido para leitura/codificação.
- **Codificação por trechos**: selecione um trecho e aplique um código. Códigos são **hierárquicos** (famílias → subcódigos), com cor por família e tonalidade por profundidade.
- **Menu de contexto**: selecione um trecho e clique com o **botão direito** para aplicar um código rapidamente.
- **Esquema de categorias** (atributos do documento), com cinco tipos:
  - **Texto Fechado** (lista suspensa)
  - **Texto Aberto** (texto livre)
  - **Data** (campos DD / MM / AAAA, aceitando datas parciais)
  - **Múltipla Escolha** (escolhe um)
  - **Caixa de Seleção** (escolhe vários)
  - Cada categoria pode ter **descrição/instrução** opcional e habilitar as opções **"Não informado"** e **"Outros"** (valor livre).
  - O **esquema de categorias e o gabarito são definidos pelos administradores**; os demais membros apenas preenchem os valores.
- **Papéis e administradores**: o criador nasce administrador; admins podem **promover/rebaixar** e **remover** membros, **renomear** e **excluir** o projeto (com trava para o projeto nunca ficar sem admin). Qualquer membro pode **sair** do projeto. Gerenciado em **⚙ → Membros & administradores**.
- **Quatro telas principais**:
  - **Codificação**: leitor à esquerda + painéis (Categorias do documento, Codificar) à direita. Filtro **"Ver:"** alterna entre suas codificações, as de outro codificador, todas ou a camada final.
  - **Reconciliação**: agrupa as codificações individuais que se sobrepõem com o mesmo código, mostra quantos codificadores concordam (consenso) e permite **consolidar** cada grupo na **camada final**.
  - **Visualização** (tela inteira): lista de trechos de **todo o projeto** (camada individual ou final), com filtro por categorias e **cruzamento de até 3 códigos por co-ocorrência**.
  - **Gráficos** (tela inteira): frequência de códigos, distribuição de documentos por categoria (gabarito), cruzamento **código × categoria** (heatmap), produção por codificador e concordância por código. Barras em HTML/CSS, sem dependências.
- **Codificação colaborativa em camadas**: cada codificação registra o autor (`código → usuário → documento`); o trabalho de cada um é independente e a equipe consolida uma camada final na tela de Reconciliação.
- **Modo coletivo** (nuvem): vários pesquisadores no mesmo projeto, com **login por e-mail/senha** (ou entrar como visitante), tela **Meus Projetos** e **sincronização ao vivo** (realtime).
- **Importação/Exportação**:
  - **QDPX** (REFI-QDA Project Exchange) — compatível com ATLAS.ti, MAXQDA, NVivo, Quirkos, Taguette.
  - **CSV** de trechos codificados e de atributos por documento.
  - **JSON** com o projeto completo.

---

## Como funciona

O app abre em um de dois modos:

- **Local** — sem servidor. Tudo fica no `localStorage` do navegador. Ideal para uso individual e offline.
- **Nuvem (coletivo)** — usa **Supabase** (Postgres + Auth + Realtime). Projetos, documentos, códigos e codificações ficam salvos na conta e são compartilhados por um **código de projeto**.

O modo é definido pela presença das credenciais do Supabase (veja [Configuração da nuvem](#configuração-da-nuvem)). Sem credenciais, o app roda em modo local.

---

## Executando

Não há etapa de build. Basta servir o `index.html`:

```bash
# qualquer servidor estático serve. Exemplos:
python -m http.server 8000
# ou
npx serve .
```

Depois abra `http://localhost:8000`. Abrir o arquivo direto pelo `file://` também funciona na maioria dos navegadores, mas servir por HTTP evita bloqueios de CORS em algumas bibliotecas.

As dependências (Preact, htm, pdf.js, mammoth, JSZip, supabase-js) são carregadas sob demanda via CDN (`esm.sh` / `jsdelivr`), então é preciso conexão com a internet na primeira carga.

---

## Configuração da nuvem

Para ativar o modo coletivo é preciso um projeto **Supabase**.

### 1. Credenciais

No `index.html`, preencha:

```js
let SUPABASE_URL = "https://SEU-PROJETO.supabase.co";
let SUPABASE_ANON_KEY = "SUA_ANON_KEY";
```

A `anon key` é pública por natureza e fica protegida pelas políticas de **RLS**. Você também pode informá-la em tempo de execução pelo botão **⚙ (Conexão)** dentro do app — nesse caso fica salva apenas no seu navegador.

### 2. Banco de dados

No **SQL Editor** do Supabase, rode o script abaixo (idempotente — pode rodar mais de uma vez).

<details>
<summary><strong>SQL completo (clique para expandir)</strong></summary>

```sql
-- ============================================================
-- QUALILAB — backend coletivo (Supabase / Postgres)
-- ============================================================

-- ---------- tabelas ----------
create table if not exists public.projects (
  id          uuid primary key default gen_random_uuid(),
  name        text not null,
  code        text not null unique,
  created_at  timestamptz not null default now(),
  created_by  uuid
);

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
-- criadores de projetos ja existentes viram admin
update public.members m set role='admin'
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
  options     jsonb not null default '[]'::jsonb,  -- valores fechados + tokens "Não informado"/"Outros"
  description text not null default '',            -- instrução/ajuda opcional por categoria
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
  layer        text not null default 'individual', -- individual (por pesquisador) | final (gabarito do dono)
  updated_at   timestamptz not null default now(),
  unique (document_id, category_id, set_by, layer)
);
-- migracao em bancos ja existentes: troca a unicidade antiga (1 valor por doc/categoria)
alter table public.doc_values add column if not exists layer text not null default 'individual';
alter table public.doc_values drop constraint if exists doc_values_document_id_category_id_key;
do $$ begin
  if not exists (select 1 from pg_constraint where conname='doc_values_uniq') then
    alter table public.doc_values add constraint doc_values_uniq unique (document_id, category_id, set_by, layer);
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
  layer        text not null default 'individual', -- individual (por codificador) | final (consolidada)
  created_by   uuid,
  author_name  text not null default 'anonimo',
  created_at   timestamptz not null default now()
);
alter table public.codings add column if not exists layer text not null default 'individual';

-- ---------- pertencimento (SECURITY DEFINER evita recursao de RLS) ----------
create or replace function public.is_member(p uuid)
returns boolean language sql security definer stable set search_path = public as $$
  select exists (select 1 from public.members where project_id = p and user_id = auth.uid());
$$;

-- administrador do projeto (papel admin em members)
create or replace function public.is_admin(p uuid)
returns boolean language sql security definer stable set search_path = public as $$
  select exists (select 1 from public.members where project_id = p and user_id = auth.uid() and role = 'admin');
$$;

-- ---------- RPCs ----------
create or replace function public.create_project(p_name text, p_display text)
returns public.projects language plpgsql security definer set search_path = public as $$
declare v_code text; v_proj public.projects;
begin
  v_code := upper(substr(replace(gen_random_uuid()::text,'-',''),1,6));
  insert into public.projects (name, code, created_by)
    values (coalesce(nullif(p_name,''),'Projeto'), v_code, auth.uid())
    returning * into v_proj;
  insert into public.members (project_id, user_id, display_name, role)
    values (v_proj.id, auth.uid(), coalesce(nullif(p_display,''),'anonimo'), 'admin');
  return v_proj;
end; $$;

-- trocar o papel de um membro (somente admin; nunca deixa o projeto sem admin)
create or replace function public.set_member_role(p_project uuid, p_user uuid, p_role text)
returns void language plpgsql security definer set search_path = public as $$
begin
  if not public.is_admin(p_project) then raise exception 'Apenas administradores podem alterar papéis'; end if;
  if p_role not in ('admin','member') then raise exception 'Papel inválido'; end if;
  if p_role='member'
     and exists (select 1 from public.members where project_id=p_project and user_id=p_user and role='admin')
     and (select count(*) from public.members where project_id=p_project and role='admin') <= 1
  then raise exception 'O projeto precisa de ao menos um administrador'; end if;
  update public.members set role=p_role where project_id=p_project and user_id=p_user;
end; $$;

-- sair / remover membro (a si mesmo, ou admin remove outro); nunca remove o ultimo admin
create or replace function public.remove_member(p_project uuid, p_user uuid)
returns void language plpgsql security definer set search_path = public as $$
begin
  if p_user <> auth.uid() and not public.is_admin(p_project) then
    raise exception 'Apenas administradores podem remover outros membros';
  end if;
  if exists (select 1 from public.members where project_id=p_project and user_id=p_user and role='admin')
     and (select count(*) from public.members where project_id=p_project and role='admin') <= 1 then
    raise exception 'O projeto precisa de ao menos um administrador';
  end if;
  delete from public.members where project_id=p_project and user_id=p_user;
end; $$;

-- renomear projeto (admin)
create or replace function public.rename_project(p_project uuid, p_name text)
returns void language plpgsql security definer set search_path = public as $$
begin
  if not public.is_admin(p_project) then raise exception 'Apenas administradores podem renomear o projeto'; end if;
  update public.projects set name = coalesce(nullif(p_name,''), name) where id = p_project;
end; $$;

-- excluir projeto (admin) — cascata apaga documentos, codigos, codificacoes, membros...
create or replace function public.delete_project(p_project uuid)
returns void language plpgsql security definer set search_path = public as $$
begin
  if not public.is_admin(p_project) then raise exception 'Apenas administradores podem excluir o projeto'; end if;
  delete from public.projects where id = p_project;
end; $$;

create or replace function public.join_project(p_code text, p_display text)
returns public.projects language plpgsql security definer set search_path = public as $$
declare v_proj public.projects;
begin
  select * into v_proj from public.projects where code = upper(trim(p_code));
  if v_proj.id is null then
    raise exception 'Projeto nao encontrado para o codigo %', p_code;
  end if;
  insert into public.members (project_id, user_id, display_name)
    values (v_proj.id, auth.uid(), coalesce(nullif(p_display,''),'anonimo'))
    on conflict (project_id, user_id) do update set display_name = excluded.display_name;
  return v_proj;
end; $$;

create or replace function public.my_projects()
returns table (id uuid, name text, code text, created_at timestamptz, n_documents bigint, n_codings bigint)
language sql security definer stable set search_path = public as $$
  select p.id, p.name, p.code, p.created_at,
    (select count(*) from public.documents d where d.project_id = p.id),
    (select count(*) from public.codings  c where c.project_id = p.id)
  from public.projects p
  where exists (select 1 from public.members m where m.project_id = p.id and m.user_id = auth.uid())
  order by p.created_at desc;
$$;

grant execute on function public.create_project(text, text)      to anon, authenticated;
grant execute on function public.join_project(text, text)        to anon, authenticated;
grant execute on function public.my_projects()                   to anon, authenticated;
grant execute on function public.is_admin(uuid)                  to anon, authenticated;
grant execute on function public.set_member_role(uuid,uuid,text) to anon, authenticated;
grant execute on function public.remove_member(uuid,uuid)        to anon, authenticated;
grant execute on function public.rename_project(uuid,text)       to anon, authenticated;
grant execute on function public.delete_project(uuid)            to anon, authenticated;

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

-- tabelas filhas: membros leem e escrevem
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

-- valores de categoria: membros leem; cada um escreve o seu (individual); só admin escreve o gabarito (final)
drop policy if exists doc_values_all    on public.doc_values;
drop policy if exists doc_values_select on public.doc_values;
drop policy if exists doc_values_own    on public.doc_values;
drop policy if exists doc_values_final  on public.doc_values;
create policy doc_values_select on public.doc_values
  for select using (public.is_member(project_id));
create policy doc_values_own on public.doc_values
  for all using (public.is_member(project_id) and set_by = auth.uid() and layer = 'individual')
         with check (public.is_member(project_id) and set_by = auth.uid() and layer = 'individual');
create policy doc_values_final on public.doc_values
  for all using (public.is_admin(project_id) and layer = 'final')
         with check (public.is_admin(project_id) and layer = 'final');

-- categorias (esquema): membros leem; somente admin cria/edita/exclui
drop policy if exists categories_all    on public.categories;
drop policy if exists categories_select on public.categories;
drop policy if exists categories_write  on public.categories;
create policy categories_select on public.categories
  for select using (public.is_member(project_id));
create policy categories_write on public.categories
  for all using (public.is_admin(project_id)) with check (public.is_admin(project_id));

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
```

</details>

### 3. Autenticação

Em **Authentication → Providers**:

- Habilite **Email** (login permanente por e-mail/senha).
- Habilite **Allow anonymous sign-ins** se quiser permitir "entrar como visitante".
- Opcional: desligue **Confirm email** para que o cadastro entre direto (sem etapa de confirmação por e-mail). O app trata os dois casos.

---

## Importação e exportação

| Formato | Importa | Exporta | Observações |
|---|:---:|:---:|---|
| **QDPX** (REFI-QDA) | ✅ | ✅ | Interoperável com ATLAS.ti, MAXQDA, NVivo, Quirkos, Taguette. Imagens/áudio/vídeo e PDFs sem texto são descartados na importação. |
| **CSV — trechos** | — | ✅ | Um trecho por linha: documento, família, código, nível, citação, posições, autor. |
| **CSV — atributos** | — | ✅ | Um documento por linha, com os valores de cada categoria. |
| **JSON** | — | ✅ | Projeto completo (documentos, categorias, códigos, codificações). |

> Na importação de QDPX, novos identificadores são gerados para evitar colisão — reimportar o mesmo arquivo cria uma cópia independente.

---

## Stack

- **Front-end**: [Preact](https://preactjs.com/) + [htm](https://github.com/developit/htm), sem build, via `esm.sh`.
- **Extração de texto**: [pdf.js](https://github.com/mozilla/pdf.js) (PDF) e [mammoth](https://github.com/mwilliamson/mammoth.js) (DOCX).
- **Empacotamento QDPX**: [JSZip](https://stuk.github.io/jszip/).
- **Backend (opcional)**: [Supabase](https://supabase.com/) — Postgres, Auth e Realtime.

---

## Estrutura

O projeto é intencionalmente **um único arquivo**: [`index.html`](index.html) contém o HTML, o CSS e todo o JavaScript (lógica, stores local e Supabase, importação/exportação e componentes de UI).

---

## Licença

Defina aqui a licença do projeto (por exemplo, MIT).
