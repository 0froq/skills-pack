# Site

A froQ site is a Nuxt app or another static app. It is not `starter-ts`.

```
app/                  pages and components
core/                 only when the site owns a spec others generate from
content/              Nuxt Content, when there is content
server/               only when there is a server
public/
nuxt.config.ts
pnpm-workspace.yaml
cloudflare.config.ts  see the cloudflare-sites skill
```

- `"private": true` unless the repo is actually published
- dependencies point at the site's catalogs
- `dev`, `generate` or `build`, `lint`, `typecheck`
- one `check` script may chain lint and typecheck
- deploy follows `cloudflare-sites`: Workers and `cf`, not a new Pages project

Do not add `tsdown`, `bumpp`, `knip`, `publint`, or a `dist` export map to a site.
Do not add `packages/*` until there is a second package.

`@froq/ui` in an app is `file:vendor/ui`. The app commits that copy. It does not depend on a git URL or an npm tag. Push and pull of that copy follow the project's `AGENTS.md`.
