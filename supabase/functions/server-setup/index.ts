// Edge Function "server-setup": the shell. The logic lives in logica.mjs (plain JavaScript, tested by
// the Node of the CI); read its header for what this function carries and what it does not.
// Secrets: QL_OAUTH_CLIENT_ID, QL_OAUTH_CLIENT_SECRET (from the OAuth app registered in the
// organization settings of Supabase; not SUPABASE_*, a prefix the dashboard refuses), ALLOWED_ORIGINS
// (comma list of the app origins, e.g. https://luizpf42.github.io,http://localhost:8002).
// verify_jwt stays ON (the platform default): the app sends the PUBLIC anon key of the project that
// hosts this function (SERVER_SETUP.key in the app), which that check accepts. The key proves
// nothing about the person; every operation past the exchange needs the token Supabase granted them,
// except the name lookup, which answers only what is public (logica.mjs). The name registry is a
// table of THIS project (registro.sql, applied once), reached with the SUPABASE_URL and
// SUPABASE_SERVICE_ROLE_KEY the platform gives every function.
import { handle } from './logica.mjs';

Deno.serve((req: Request) => handle(req, Deno.env.toObject(), fetch));
