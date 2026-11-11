# Deploy with `void`

`void` (npm `void`, v1.7.0) is a Cloudflare Workers framework and deploy
CLI. It builds the project itself, provisions resources, and deploys. Use
it for a **server** app: Worker plus bindings, Durable Objects, KV,
secrets. A pure static site still uses `cf` (see `deploy-cloudflare.md`).

Reference implementation: `0froq/osdash`.

## `void.config.ts` is the source of truth

```ts
import { defineConfig } from 'void/config'

export default defineConfig({
  target: 'cloudflare',
  inference: {
    appType: 'framework',           // Nuxt is a meta-framework
    build: 'pnpm exec vp run build',
    bindings: { ai: 'AI' },
  },
  cloudflare: {
    name: 'osdash',
    durable_objects: { bindings: [{ name: 'DEVICE_RELAY', class_name: 'DeviceRelay' }] },
    migrations: [{ tag: 'device-relay-v1', new_sqlite_classes: ['DeviceRelay'] }],
    routes: [{ pattern: 'osdash.froq.me', custom_domain: true }],
    workers_dev: false,
    preview_urls: true,
    compatibility_date: '2026-10-19',
    compatibility_flags: ['nodejs_compat', 'nodejs_als'],
    observability: { enabled: true, traces: { enabled: true } },
  },
})
```

`inference.appType` is one of `void`, `framework`, `spa`, `static`. Nuxt
maps to `framework`, while `static` uploads files with no Worker at all.

`void deploy` runs `inference.build` itself. Do not chain a build in front
of it, and do not run a second build in CI.

## Scripts

```json
{
  "deploy": "void deploy --platform cloudflare",
  "preview:deploy": "pnpm build && cf previews deploy"
}
```

Production goes through Void. Preview stays on `cf`, with
`cloudflare.config.ts` as the preview-only adapter. It reads `name`,
compatibility date/flags, observability, `workers_dev`, and
`preview_urls` from `void.config.ts`. It deliberately does **not** copy
`routes`, so a branch preview never claims the production domain.

`workers_dev: false` with `preview_urls: true` is explicit on purpose:
Cloudflare's default makes `preview_urls` follow `workers_dev`, so turning
`workers_dev` off without setting `preview_urls` kills previews too.

## Nitro and Vite wiring

- Nitro preset `cloudflare-module`. Bindings are read from
  `event.context.cloudflare.env`.
- `vite.config.ts` adds `voidPlugin()`.
- Nitro does not read `void.config.ts` or `wrangler.config.ts` to decide on
  Node compatibility. It only scans `wrangler.json`/`.jsonc`/`.toml`.
  Without one it warns `Node.js compatibility is not enabled`. Set
  `nitro.cloudflare.nodeCompat: true` in `nuxt.config.ts`. Keep
  `compatibility_flags` in the Void config as well, since that is what the
  deploy passes to Cloudflare.
- `nitro.cloudflare.dev.configPath` points at `./.void-wrangler.jsonc`
  during dev. Add `.void` and `.void-wrangler.jsonc` to `.gitignore`.

## Config vs secrets

- Non-secret bindings and vars declared in `void.config.ts` → `cloudflare`.
- KV namespaces that need an id live in `cloudflare` too, but the id only
  exists after a first real deploy writes `void.lock.json`. Do not invent
  one.
- Runtime secrets go through `void secret put NAME`, never into
  `void.config.ts` `vars` and never into the repo.
- Declare the env surface once in `env.ts` with `defineEnv` from
  `void/env` (`froq-stack` → `references/runtime.md`). Local values live in
  `.env`, which is gitignored and not uploaded by deploy.

## `void.lock.json`

Commit it. It records the account id and provisioned resource ids (KV
namespace, etc.) from the first real deploy, which is what lets a clean CI
checkout reuse the same namespaces.

## Workers Builds

- Build command: **empty**. `void deploy` runs `inference.build`, and
  `preview:deploy` runs its own build. Filling it in builds twice.
- Deploy command: `pnpm exec void deploy --platform cloudflare`.
- Credentials come from the build environment:
  `CLOUDFLARE_API_TOKEN` and `CLOUDFLARE_ACCOUNT_ID`. Void 1.1.12 uses the
  token when present and skips `whoami`/login. `WORKERS_CI` is recognized
  as CI, so it takes the non-interactive path. The account is read from
  `void.lock.json` or the config's `account_id` first, then
  `CLOUDFLARE_ACCOUNT_ID`.
- Access probe: Void's `/__void/ready` reads `CF_ACCESS_CLIENT_ID` and
  `CF_ACCESS_CLIENT_SECRET` and sends `CF-Access-Client-Id`/
  `CF-Access-Client-Secret` headers, preferring them over
  `CF_ACCESS_TOKEN`. The Access application in front of the probe target
  (the Worker Version preview URL) must allow the service token with a
  `Service Auth` policy. Void has no flag to skip the probe. Put these in
  build variables, not Worker runtime vars.
- Preview Worker secrets (`GITHUB_TOKEN`, `ACCESS_TEAM_DOMAIN`,
  `ACCESS_AUD`, …) need to be written again for the preview target, since
  `cf previews deploy` does not inherit production secrets.

## CLI surface worth knowing

```
void init [--tsconfig] [--github]   set up Void in a project
void migrate                        move legacy settings into void.config.ts
void connect [url] --platform cloudflare|void
void info [--json]                  inspect persistent resource names, no deploy
void deploy [--project] [--dir] [--spa] [--skip-build] [--provision] [--atomic]
void secret put <NAME>
void auth login|status|logout
void cloudflare login|status|logout
```

`--provision` re-runs resource provisioning (e.g. enabling D1 read
replication). `--atomic` skips pre-traffic staging for a Durable Object
Worker. `--dir` deploys a static directory and skips the build.

## Boundaries

- Do not run `wrangler` commands. `wrangler` stays a devDependency only
  because Nitro's Cloudflare preset and the preview adapter read its
  config types.
- Do not put production routes in the preview adapter.
- Do not hand-edit `void.lock.json`.
- A first real deploy is required before trusting resource ids. Until
  then, treat "Void will pick this up" as unverified.

## Docs

- https://void.cloud/guide/app-types
- https://void.cloud/integrations/frameworks/nuxt
- https://void.cloud/reference/config
- https://void.cloud/guide/env-vars
- https://developers.cloudflare.com/cf/projects/cloudflare-config/
