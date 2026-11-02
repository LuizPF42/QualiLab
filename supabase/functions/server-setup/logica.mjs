// "CREATE MY GROUP'S SERVER" — the one server piece of it (out/2026).
//
// WHY A SERVER AT ALL: Supabase answers neither its OAuth token endpoint nor its management API to
// a page outside supabase.com (CORS, measured 23/out/2026 from github.io, localhost and a made-up
// domain: only https://supabase.com gets Access-Control-Allow-Origin), and the token exchange
// needs the app's CLIENT SECRET, which cannot live in a page. So this function makes those calls,
// and only those.
//
// WHAT IT CARRIES, AND WHAT IT DOES NOT: it sees, for the length of each call, a short-lived token
// that the person granted on supabase.com, with the scopes the OAuth app was registered with. It
// keeps no state, logs nothing it carries, and answers a FIXED list of operations (no generic proxy:
// the page names an operation, never a path). The research data never passes here: the project is
// created in the group's own account, and the corpus goes from the browser straight to it. Secret
// API keys are filtered out HERE, so they never reach the browser at all.
//
// THE NAME REGISTRY (table cloud_names in the project that hosts this function, registro.sql): a
// short name a colleague types instead of the address and key of the group's cloud. It holds only
// what is public anyway, the address and the PUBLIC key (the same pair the team link carries): no
// e-mail, no account, nothing about who is in the group. Knowing a name gets someone to the sign-in
// of that cloud and no further (an account there sees no project without a code from the admin).
// Only someone whose Supabase account reaches the project registers a name for it, and the address
// and key are read from Supabase, never taken from the caller: otherwise a name could be pointed at
// a look-alike server that collects the passwords typed into it.
//
// Plain JavaScript on purpose: index.ts (Deno, the Edge Function) imports it, and the Node 20 of the
// CI imports it to test it with a fake fetch.

const API = 'https://api.supabase.com';
// region codes the create endpoint accepts (from the management API spec, read 23/out/2026)
export const SETUP_REGIONS = ['sa-east-1', 'us-east-1', 'us-east-2', 'us-west-1', 'us-west-2', 'ca-central-1',
  'eu-west-1', 'eu-west-2', 'eu-west-3', 'eu-north-1', 'eu-central-1', 'eu-central-2',
  'ap-south-1', 'ap-southeast-1', 'ap-southeast-2', 'ap-northeast-1', 'ap-northeast-2', 'ap-east-1'];
const REF_RE = /^[a-z0-9]{20}$/;
const SLUG_RE = /^[a-z0-9][a-z0-9_-]{0,63}$/;
const SQL_MAX = 2 * 1024 * 1024;
// 3 to 40 characters, plain lowercase letters, digits and hyphens, no hyphen at the ends (the same
// rule as the check of cloud_names in registro.sql and as CLOUD_NAME_RE in the app)
export const CLOUD_NAME_RE = /^[a-z0-9](?:[a-z0-9-]{1,38}[a-z0-9])$/;

function allowedOrigins(env){
  return String((env && env.ALLOWED_ORIGINS) || '').split(',').map(s => s.trim().replace(/\/+$/, '')).filter(Boolean);
}
// an address belongs to the app if it is one of the allowed origins or lives under one. A comma or a
// space is legal inside a URL here and a separator there: uri_allow_list is a comma-separated list on
// Supabase's side, so `app/x,https://elsewhere/*` would pass as one address and arrive as two.
function underAllowed(url, allowed){
  if(/[\s,]/.test(String(url))) return false;
  try {
    const u = new URL(url);
    return (u.protocol === 'https:' || u.hostname === 'localhost' || u.hostname === '127.0.0.1') && allowed.includes(u.origin);
  } catch(e){ return false; }
}
function reply(status, body, cors){
  return new Response(JSON.stringify(body), { status, headers: { ...cors, 'Content-Type': 'application/json' } });
}
function randomPassword(){
  const b = new Uint8Array(24);
  crypto.getRandomValues(b);
  let s = '';
  for(const x of b) s += String.fromCharCode(x);
  return btoa(s).replace(/\+/g, '-').replace(/\//g, '_').replace(/=+$/, '');
}
// the registry, through this project's own REST API with its service key (the platform gives every
// function SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY). The table has its grants revoked, so a wrong
// key FAILS instead of reading an empty table as "no such name"
function registry(env, f){
  const base = String((env && env.SUPABASE_URL) || '').replace(/\/+$/, ''), sk = String((env && env.SUPABASE_SERVICE_ROLE_KEY) || '');
  if(!base || !sk) return null;
  const h = { apikey: sk, Authorization: 'Bearer ' + sk, 'Content-Type': 'application/json', Accept: 'application/json' };
  return {
    get: name => f(base + '/rest/v1/cloud_names?select=url,anon_key&name=eq.' + encodeURIComponent(name), { method: 'GET', headers: h }),
    // one name per project: registering again replaces the project's name (merge on ref); a name
    // that belongs to ANOTHER project breaks the primary key, and PostgREST answers 409
    put: row => f(base + '/rest/v1/cloud_names?on_conflict=ref', { method: 'POST',
      headers: { ...h, Prefer: 'resolution=merge-duplicates,return=minimal' }, body: JSON.stringify(row) }),
  };
}
// the key the app connects with, in the order the app picks it (provisionServer: anon, then publishable)
function publicKeyOf(list){
  const arr = Array.isArray(list) ? list : [];
  const anon = arr.find(k => k && k.name === 'anon' && (k.type === 'legacy' || k.type == null));
  const pub = arr.find(k => k && k.type === 'publishable');
  return (anon && anon.api_key) || (pub && pub.api_key) || null;
}

// the upstream error, short and without anything that came from the caller
async function upstreamError(r){
  let msg = '';
  try { const j = await r.json(); msg = String((j && (j.message || j.error_description || j.error)) || ''); } catch(e){}
  return { error: 'upstream', status: r.status, message: msg.slice(0, 300) };
}

export async function handle(req, env, fetchImpl){
  const f = fetchImpl || fetch;
  const allowed = allowedOrigins(env);
  const origin = req.headers.get('origin') || '';
  const ok = allowed.includes(origin);
  // authorization + apikey: the app sends the PUBLIC key of the project hosting this function, so
  // the platform's own JWT check can stay on (it accepts that key); the preflight has to allow them
  const cors = ok ? { 'Access-Control-Allow-Origin': origin, 'Vary': 'Origin',
    'Access-Control-Allow-Headers': 'authorization, apikey, content-type, x-client-info', 'Access-Control-Allow-Methods': 'POST, OPTIONS' } : {};
  if(req.method === 'OPTIONS') return new Response(null, { status: ok ? 204 : 403, headers: cors });
  if(!ok) return reply(403, { error: 'origin' }, cors);
  if(req.method !== 'POST') return reply(405, { error: 'method' }, cors);
  let body;
  try { body = await req.json(); } catch(e){ return reply(400, { error: 'json' }, cors); }
  const op = body && body.op;

  if(op === 'exchange'){
    // QL_, not SUPABASE_: the dashboard refuses custom secrets with the SUPABASE_ prefix (measured 24/out/2026)
    if(!env.QL_OAUTH_CLIENT_ID || !env.QL_OAUTH_CLIENT_SECRET) return reply(500, { error: 'not_configured' }, cors);
    const code = String(body.code || ''), verifier = String(body.code_verifier || ''), redirect = String(body.redirect_uri || '');
    if(!code || !verifier) return reply(400, { error: 'args' }, cors);
    // the redirect must be the app itself: a code minted for another address is not ours to spend
    if(!underAllowed(redirect, allowed)) return reply(400, { error: 'redirect' }, cors);
    const form = new URLSearchParams({ grant_type: 'authorization_code', code, code_verifier: verifier, redirect_uri: redirect });
    const r = await f(API + '/v1/oauth/token', { method: 'POST', body: form.toString(), headers: {
      'Content-Type': 'application/x-www-form-urlencoded', Accept: 'application/json',
      Authorization: 'Basic ' + btoa(env.QL_OAUTH_CLIENT_ID + ':' + env.QL_OAUTH_CLIENT_SECRET) } });
    if(!r.ok) return reply(502, await upstreamError(r), cors);
    const t = await r.json();
    return reply(200, { access_token: t.access_token, expires_in: t.expires_in }, cors);
  }

  // the name -> address lookup needs no token: what it answers is public (see the header)
  if(op === 'lookup'){
    const name = String(body.name || '');
    if(!CLOUD_NAME_RE.test(name)) return reply(400, { error: 'args' }, cors);
    const reg = registry(env, f);
    if(!reg) return reply(500, { error: 'no_registry' }, cors);
    const r = await reg.get(name);
    if(!r.ok) return reply(502, await upstreamError(r), cors);
    const rows = await r.json();
    if(!Array.isArray(rows) || !rows.length) return reply(404, { error: 'not_found' }, cors);
    return reply(200, { url: rows[0].url, key: rows[0].anon_key }, cors);
  }

  const token = String(body.token || '');
  if(!token) return reply(401, { error: 'token' }, cors);
  const call = (method, path, payload) => f(API + path, { method, headers: {
    Authorization: 'Bearer ' + token, 'Content-Type': 'application/json', Accept: 'application/json' },
    body: payload === undefined ? undefined : JSON.stringify(payload) });
  const ref = String(body.ref || '');
  const needRef = () => REF_RE.test(ref);

  if(op === 'orgs'){
    const r = await call('GET', '/v1/organizations');
    if(!r.ok) return reply(502, await upstreamError(r), cors);
    return reply(200, { orgs: (await r.json()).map(o => ({ slug: o.slug, name: o.name })) }, cors);
  }
  if(op === 'create'){
    const name = String(body.name || '').trim(), org = String(body.org || ''), region = String(body.region || '');
    if(!name || name.length > 64 || !SLUG_RE.test(org) || !SETUP_REGIONS.includes(region)) return reply(400, { error: 'args' }, cors);
    const dbPass = randomPassword();
    const r = await call('POST', '/v1/projects', { name, organization_slug: org, db_pass: dbPass,
      region_selection: { type: 'specific', code: region } });
    if(!r.ok) return reply(502, await upstreamError(r), cors);
    const p = await r.json();
    // the database password is created here and handed over ONCE; nothing keeps a copy
    return reply(200, { ref: p.ref, status: p.status, db_pass: dbPass }, cors);
  }
  if(op === 'status'){
    if(!needRef()) return reply(400, { error: 'ref' }, cors);
    const r = await call('GET', '/v1/projects/' + ref);
    if(!r.ok) return reply(502, await upstreamError(r), cors);
    return reply(200, { status: (await r.json()).status }, cors);
  }
  // ONE request is ONE transaction on the API side: measured 25/out/2026 on a test project (183 KB, 3,004
  // statements and an error in the last one: all undone). An update the database refused leaves the
  // server as it was, and the app's update screen says so.
  if(op === 'schema'){
    const sql = String(body.sql || '');
    if(!needRef() || !sql || sql.length > SQL_MAX) return reply(400, { error: 'args' }, cors);
    const r = await call('POST', '/v1/projects/' + ref + '/database/query', { query: sql });
    if(!r.ok) return reply(502, await upstreamError(r), cors);
    return reply(200, { ok: true }, cors);
  }
  if(op === 'auth'){
    const site = String(body.site_url || ''), redirect = String(body.redirect || '');
    // the sign-in of the new server points back to THIS app, nowhere else
    if(!needRef() || !underAllowed(site, allowed) || !underAllowed(redirect.replace(/\*+$/, ''), allowed)) return reply(400, { error: 'args' }, cors);
    const r = await call('PATCH', '/v1/projects/' + ref + '/config/auth', {
      site_url: site, uri_allow_list: redirect, external_email_enabled: true, mailer_autoconfirm: true });
    if(!r.ok) return reply(502, await upstreamError(r), cors);
    return reply(200, { ok: true }, cors);
  }
  if(op === 'keys'){
    if(!needRef()) return reply(400, { error: 'ref' }, cors);
    const r = await call('GET', '/v1/projects/' + ref + '/api-keys');
    if(!r.ok) return reply(502, await upstreamError(r), cors);
    const list = await r.json();
    const anon = list.find(k => k && k.name === 'anon' && (k.type === 'legacy' || k.type == null));
    const pub = list.find(k => k && k.type === 'publishable');
    // secret / service_role keys never leave this function
    return reply(200, { anon: anon ? anon.api_key : null, publishable: pub ? pub.api_key : null }, cors);
  }
  if(op === 'register'){
    const name = String(body.name || '');
    if(!needRef() || !CLOUD_NAME_RE.test(name)) return reply(400, { error: 'args' }, cors);
    const reg = registry(env, f);
    if(!reg) return reply(500, { error: 'no_registry' }, cors);
    // the person's own Supabase account has to reach the project; a refusal is "not yours", any other
    // failure of the API is the API's (not a verdict about the person)
    const own = await call('GET', '/v1/projects/' + ref);
    if(own.status === 401 || own.status === 403 || own.status === 404) return reply(403, { error: 'not_owner' }, cors);
    if(!own.ok) return reply(502, await upstreamError(own), cors);
    const kr = await call('GET', '/v1/projects/' + ref + '/api-keys');
    if(!kr.ok) return reply(502, await upstreamError(kr), cors);
    const key = publicKeyOf(await kr.json());
    if(!key) return reply(502, { error: 'no_key' }, cors);
    // the address and the key come from Supabase, never from the body of the request
    const r = await reg.put({ name, ref, url: 'https://' + ref + '.supabase.co', anon_key: key, updated_at: new Date().toISOString() });
    if(r.status === 409) return reply(409, { error: 'taken' }, cors);
    if(!r.ok) return reply(502, await upstreamError(r), cors);
    return reply(200, { ok: true, name }, cors);
  }
  return reply(400, { error: 'op' }, cors);
}
