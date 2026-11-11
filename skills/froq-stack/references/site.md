# Site

A froQ site is a Nuxt app (or another static app). It is not a published
library.

```
app/                  pages and components
core/                 only when the site owns a spec others generate from
content/              Nuxt Content, when there is content
server/               only when there is a server
public/
nuxt.config.ts
vite.config.ts        lint / fmt / staged blocks
pnpm-workspace.yaml
void.config.ts        deploy target (server apps)
wrangler.config.ts    preview adapter
cloudflare.config.ts  preview adapter
```

## package.json

- `"private": true`. A site is never published unless it really is
- dependencies point at the repo's catalogs
- scripts: `dev`, `generate` or `build`, `lint`, `fmt`, `typecheck`,
  `check`, `postinstall` = `nuxt prepare`, `prepare` = `npx simple-git-hooks`
- `check` chains lint, fmt check, and typecheck. Add token and
  generated-file checks when the repo has them
- `test` only when a non-UI package inside the repo has tests:
  `vp test --config tooling/vite.config.ts`

## Static site vs server app

**Static site** (`lig`): `nuxt generate`, then `cf deploy`. Preview with
`cf previews deploy`. `wrangler.config.ts` plus `cloudflare.config.ts`.

**Server app** (`osdash`): `void deploy --platform cloudflare`, with a
`void.config.ts` declaring target, routes, and bindings:

```ts
export default defineConfig({
  target: 'cloudflare',
  inference: { appType: 'framework', build: 'pnpm exec vp run build' },
  cloudflare: {
    name: 'osdash',
    routes: [{ pattern: 'osdash.froq.me', custom_domain: true }],
    compatibility_flags: ['nodejs_compat', 'nodejs_als'],
  },
})
```

`cloudflare.config.ts` stays as the preview adapter in both cases.
Deploy specifics belong to `froq-web-app`.

## `@froq/ui` in a site

Vendored, not installed from git or npm: `file:vendor/ui`. The app commits
that copy. Push and pull of the copy follow the project's `AGENTS.md`.

Because the copy is editable source, `nuxt.config.ts` aliases the package
name at the vendored path:

```ts
alias: {
  '@froq/ui': fileURLToPath(new URL('./vendor/ui/src/index.ts', import.meta.url)),
  '@froq/ui/style.css': fileURLToPath(new URL('./vendor/ui/src/style.css', import.meta.url)),
  '@froq/ui/tokens.css': fileURLToPath(new URL('./vendor/ui/src/tokens.css', import.meta.url)),
}
```

This is package-name aliasing for a vendored dependency, not a `paths`
alias for own source code. The no-alias rule in `froq-code-style` still
holds for app code.

## Do not add

- `tsdown`, `bumpp`, `knip`, `publint`, or a `dist` export map
- `packages/*` until there is a second package
- UnoCSS to a new site (see `unocss.md`)
