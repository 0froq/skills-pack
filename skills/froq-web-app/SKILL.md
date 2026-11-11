---
name: froq-web-app
description: Architecture and deploy for froQ web apps. Use when starting a site, choosing static vs server, wiring Cloudflare Workers, migrating off Pages, or configuring Workers Builds and previews. Site layout and Nuxt config live in froq-stack.
license: MIT
metadata:
  author: froQ
  version: "0.2.0"
  source: Hand-written from froQ repos (poim, lig, osdash, void). https://github.com/0froq/skills-pack
---

# froq-web-app

Web apps only: what shape a site takes and how it reaches Cloudflare.
Everything else about a repo is `froq-stack`.

## Architecture decisions

Three things to settle before writing code:

1. **Static or server.** Default is static generation (Nitro
   `preset: 'static'`). Go server-side only when there is a concrete need —
   list the endpoints or bindings it buys you first. Static assets on
   Workers cost the same as on Pages, so there is no cost argument for
   Pages.
2. **Framework.** Nuxt/Vue by default. Layout and Nuxt config:
   `froq-stack` → `references/site.md` and `references/nuxt.md`.
3. **Deploy target.** Cloudflare Workers, never a new Pages project. Two
   entry points:
   - **`cf`** — static sites and anything that only ships assets.
   - **`void`** — server apps, Durable Objects, KV bindings, secrets
     provisioning.

## Deploy routing

| Repo shape | Deploy | Reference |
| --- | --- | --- |
| Static / SSG Nuxt site (`lig`, `poim`, `void` site) | `cf` | [deploy-cloudflare](references/deploy-cloudflare.md) |
| Server app with Worker + bindings (`osdash`) | `void` for prod, `cf` for preview | [deploy-void](references/deploy-void.md) |

`cf` is beta and its command surface moves; pin the version. `void` is the
newer path and does its own build and resource provisioning.

Both keep the same three rules:

- No Pages project, ever. New work starts on Workers.
- GitHub connection in the Workers Builds console. No API token in the
  repo.
- Preview deploys are a separate command from production.

## Reference samples

`0froq/poim` main is the reference for a new static site
([PR #5](https://github.com/0froq/poim/pull/5)). Do not copy `void`,
`paper-landing`, or `lig` deploy setups — the reasons are in
`deploy-cloudflare.md`.

## Boundaries

- No `wrangler` commands; it stays a devDependency only because Nitro and
  the preview adapter read its config types.
- No `preset: 'cloudflare_pages'` — it writes `_routes.json`/`_redirects`
  and warns about D1.
- No `cf:build` scripts and no swapping `pnpm dev` for `cf dev`.
- No API tokens committed for deploys; use the console's GitHub connection
  or `CLOUDFLARE_API_TOKEN` from the environment.
- No trailing-slash redirects on a static site (see the reference for why).

## Hand-offs

- Site layout, Nuxt config, catalogs: `froq-stack`
- Runtime pinning (Node, pnpm, env): `froq-stack` → `references/runtime.md`
- In-repo code conventions: `froq-code-style`
- Design direction: `froq-design`

## References

- [deploy-cloudflare](references/deploy-cloudflare.md): `cf` path —
  Workers static assets, migration off Pages/wrangler, Workers Builds,
  previews, version pinning
- [deploy-void](references/deploy-void.md): `void` path — `void.config.ts`,
  build inference, bindings, secrets, lockfile, preview adapter
