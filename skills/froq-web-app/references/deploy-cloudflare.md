# Deploy with `cf` (Cloudflare Workers)

New froQ static and Nuxt sites deploy to Cloudflare Workers (static
assets) with `cf`. Do not create a Pages project, and do not copy the
deploy setups of `void`, `paper-landing`, or `lig`. Reference sample:
[0froq/poim](https://github.com/0froq/poim) main
([PR #5](https://github.com/0froq/poim/pull/5)).

## Repos not to copy

- `void` site: first a Worker plus a GitHub Action with an API token in the
  repo, later a Pages GitHub connection. Both are old decisions.
- `paper-landing`: Pages GitHub connection, builds `pnpm generate`,
  publishes `.output/public`. No wrangler.
- `lig`: no deploy config of its own.

New sites and sites migrating off Pages both follow this reference. On
migration, create a new Worker — do not reuse the Pages project, the
repo's API token, or `preset: 'cloudflare_pages'`.

## Pages is closed to new work

`cf` cannot create a Pages project; the console entry is gone. Cloudflare
still says existing Pages projects stay up, but new projects start on
Workers. Static asset requests on Workers are not billed per request, same
as Pages. `wrangler pages project create` still exists; that is not the
path for a new site.

## When a repo already has wrangler config

The repo has `wrangler.jsonc` or `wrangler.toml` and no
`cloudflare.config.ts`:

1. Working tree must be clean. `cf migrate` stops on a dirty tree unless
   you pass `--force`.
2. Install wrangler, at least 4.136 — `cf`'s Wrangler bundler needs it.
3. Run `cf migrate`. It writes `cloudflare.config.ts`. Without
   `@cloudflare/vite-plugin`, the assets directory goes in
   `wrangler.config.ts` under `assetsDirectory`.
4. It does not overwrite an existing `cloudflare.config.ts`, and it does not
   delete the old `wrangler.jsonc`.
5. Delete `wrangler.jsonc` only after `cf deploy --dry-run` passes.

With no `cloudflare.config.ts` yet, do not run `cf init`, `cf dev`,
`cf build`, or `cf deploy` — they do not read `wrangler.jsonc` and may
rewrite the config.

## Nuxt static site

Nitro with the static preset, public dir pointed at `dist`. Never set
`preset: 'cloudflare_pages'`: that preset writes `_routes.json` and
`_redirects` (`/* /404.html 404`) and warns about switching to D1.
Workers Builds sets `WORKERS_CI`, which would otherwise make Nitro pick a
Cloudflare preset by itself.

```ts
nitro: {
  preset: 'static',
  output: { publicDir: 'dist' },
}
```

`cloudflare.config.ts` holds the Worker itself. `compatibilityDate` is the
day you do the work. The name may start with a digit.

```ts
import { defineConfig } from 'cf/config'

export default defineConfig({
  worker: {
    name: '<worker-name>',
    compatibilityDate: '<YYYY-MM-DD>',
    observability: { enabled: true, traces: { enabled: true } },
    assets: {
      htmlHandling: 'drop-trailing-slash',
      notFoundHandling: '404-page',
    },
  },
})
```

`wrangler.config.ts` holds only the build-side assets directory. It is not
Pages config — never write `pages_build_output_dir` there.

```ts
import { defineWranglerConfig } from 'wrangler/experimental-config'

export default defineWranglerConfig({
  types: { generate: false },
  assetsDirectory: './dist',
})
```

Keep `dev`, `build`, `generate` in `package.json` and add:

```json
"deploy": "pnpm generate && cf deploy",
"preview:deploy": "pnpm generate && cf previews deploy"
```

`cf build` and `cf deploy` do not run `package.json` scripts, so generation
has to be chained in front. Do not replace `pnpm dev` with `cf dev`. Do not
add a `cf:build` script. Deploy and preview with `cf` only — no wrangler,
no `wrangler build --x-cf-build-output`, no `--prebuilt`.
`cf previews deploy --prebuilt` fails: prebuilt output is not a preview
build.

Nuxt routes have no trailing slash while static files are
`folder/index.html`. `auto-trailing-slash` 307s `/s/0001/homepage` to
`/s/0001/homepage/`, and the empty segment then 404s on the document path.
Use `drop-trailing-slash`. If a page builds slugs itself, drop empty
segments.

`public/_headers` is copied into `dist` — use it for cache headers on
`/_nuxt`. Put `.cloudflare` and `.wrangler` in `.gitignore`.

## Workers Builds

Console settings (GitHub connection, no API token in the repo):

- Build command: `pnpm generate`
- Production deploy: `pnpm exec cf deploy` (the pinned `cf` from the project)
- Turn on Worker Previews (one time, cannot be undone). Preview command:
  `pnpm exec cf previews deploy`. Turn on Builds for Preview branches.
- Set `NODE_VERSION=22` on both Production and Previews Base
- API token name: `Workers Builds - 2026-09-19 22:23`

Preview URLs: branch alias
`<branch-slug>-<worker>.sayhola.workers.dev` (stable per PR, later builds
update the same one), plus `<hash>-<worker>.sayhola.workers.dev` per
commit. Cloudflare's PR comment says "No Preview URL" when you use `cf` —
only `wrangler preview` fills that in. Expected; take the address from the
alias or the build log. Keep using `cf`; do not switch to wrangler just for
that comment.

Worker Previews do not inherit production vars, bindings, or secrets. Write
what a preview needs into Previews Base. For a static site both sides need
only `NODE_VERSION`.

Do not click Retry after changing console settings — Retry reuses the old
settings. Push a new commit instead.

`cf workers-builds workers migrate-to-previews` is a one-time,
irreversible step, and only for a Worker already on Workers Builds with the
old non-production trigger. New Workers are already preview-native; do not
run the migration on them.

## Version pinning

- `cf` is beta; commands and config format still move. Verified version is
  `1.0.0-beta.12` — pin it, do not track latest.
- Loading `cloudflare.config.ts` needs Node.js >= 22.18
  (`module.registerHooks`). The error message can look like a Bun problem;
  check `node -v` first.
- Once a project declares `cf`, a global `cf` forwards to the project's
  copy.
- `cf deploy --dry-run` needs no login — use it to confirm assets made it
  into the bundle. Do not add `--prebuilt`.
- `cf auth login` opens a browser. For unattended runs use
  `CLOUDFLARE_API_TOKEN` from the environment, never in the repo.

## Docs

- https://developers.cloudflare.com/cf/wrangler/migrate/
- https://developers.cloudflare.com/cf/projects/
- https://developers.cloudflare.com/workers/static-assets/routing/static-site-generation/
- https://developers.cloudflare.com/workers/previews/
- https://developers.cloudflare.com/workers/ci-cd/builds/configuration/
- https://developers.cloudflare.com/pages/get-started/
