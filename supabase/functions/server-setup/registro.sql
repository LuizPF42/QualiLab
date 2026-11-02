-- THE NAME REGISTRY of the server-setup function (out/2026). Apply ONCE, in the project that
-- HOSTS the function (SQL Editor of that project). It is NOT part of supabase/schema.sql, and it does
-- not go into the groups' clouds.
--
-- What it holds is public anyway: a short name, the address of a group's cloud and its PUBLIC key
-- (the same pair the team link carries). No e-mail, no account, nothing about who is in the group.
-- The function writes a row only for a project the person's Supabase account reaches, and reads the
-- address and the key from Supabase itself (logica.mjs, op "register").
create table if not exists public.cloud_names (
  name text primary key,
  ref text not null unique,
  url text not null,
  anon_key text not null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  -- the same rule as CLOUD_NAME_RE in logica.mjs and in the app
  constraint cloud_names_name_check check (name ~ '^[a-z0-9]([a-z0-9-]{1,38}[a-z0-9])$'),
  constraint cloud_names_ref_check check (ref ~ '^[a-z0-9]{20}$'),
  -- the address is the project's own, never an arbitrary one
  constraint cloud_names_url_check check (url = 'https://' || ref || '.supabase.co')
);
-- only the function reaches it, with this project's service key: RLS on with no policy, AND the
-- grants revoked. The revoke is what makes a wrong key FAIL (permission denied) instead of reading
-- the table as empty, which the app would show as "no cloud with this name".
alter table public.cloud_names enable row level security;
revoke all on public.cloud_names from public, anon, authenticated;
