# Site

A froQ site is a Nuxt app or another static app. It is not `starter-ts`.
Conventions target [0froq/lig](https://github.com/0froq/lig) once it is on `@liangmi/vp-config`. `paper-landing` is a legacy Pages repo only.

```
app/                  pages and components
core/                 only when the site owns a spec others generate from
content/              Nuxt Content, when there is content
server/               only when there is a server
public/
nuxt.config.ts        Nuxt owns app Vite
vite.config.ts        liangmi() for lint / fmt — see vp-config.md
pnpm-workspace.yaml
cloudflare.config.ts  see the cloudflare-sites skill
```

- `"private": true` unless the repo is actually published
- dependencies point at the site's catalogs
- Node 24.21 (`.node-version` / `engines`)
- `dev`, `generate` or `build` stay Nuxt; `lint`, `fmt`, `check` go through `vp` ([vp-config.md](vp-config.md))
- one `check` script chains lint, format check, and `nuxt typecheck`
- deploy follows `cloudflare-sites`: Workers and `cf` (`pnpm generate` then `cf deploy` / `cf previews deploy`), not a new Pages project and not the wrangler CLI

Do not add `tsdown`, `bumpp`, `knip`, `publint`, or a `dist` export map to a site.
Do not add `packages/*` until there is a second package.
Do not add ESLint or `@nuxt/eslint` to a new site.

`@froq/ui` in an app is `file:vendor/ui`. The app commits that copy. It does not depend on a git URL or an npm tag. Push and pull of that copy follow the project's `AGENTS.md`.
