# Runtime and repo conventions

Cross-cutting choices that every froQ repo shares, independent of form.

## Node and pnpm pinning

Pin the same Node in three places, and keep them in sync:

```
mise.toml            [tools] node = "24.21.0"
package.json         "engines": { "node": "^24.21.0 || >=26.0.0" }
package.json         "packageManager": "pnpm@12.11.2"
```

`mise.toml` is what actually selects the runtime locally. `engines` states
the supported range (current froQ repos: `^24.21.0 || >=26.0.0`, while older
ones still say `>=22.18.0`). `packageManager` pins pnpm. A **published**
library can include the integrity hash
(`pnpm@12.11.2+sha512.…`), a private site does not need it.

Do not bump pnpm to match a template. `onlyBuiltDependencies` /
`allowBuilds` have to match the pinned major.

## tsconfig

**Nuxt repo.** Project references only, nothing else:

```json
{
  "references": [
    { "path": "./.nuxt/tsconfig.app.json" },
    { "path": "./.nuxt/tsconfig.server.json" },
    { "path": "./.nuxt/tsconfig.shared.json" },
    { "path": "./.nuxt/tsconfig.node.json" }
  ],
  "files": []
}
```

Nuxt generates the real configs. Adding `paths` or `baseUrl` here fights
the generator and breaks `nuxt typecheck`.

**Library or plain TS repo.** Explicit strict config:

```json
{
  "compilerOptions": {
    "target": "ESNext",
    "lib": ["ESNext", "DOM", "DOM.Iterable"],
    "module": "ESNext",
    "moduleResolution": "Bundler",
    "types": ["node"],
    "strict": true,
    "noUncheckedIndexedAccess": true,
    "noEmit": true,
    "isolatedModules": true,
    "verbatimModuleSyntax": true,
    "skipLibCheck": true
  }
}
```

`noUncheckedIndexedAccess` and `verbatimModuleSyntax` are on by choice.
Keep them. No `paths`, no `baseUrl`.

## `tooling/`

Tool configuration that must not sit at the root, because a framework owns
the root config file:

```ts
// tooling/vite.config.ts — Nuxt owns vite.config.ts, so tests live here
import { defineConfig } from 'vite-plus'

export default defineConfig({
  tsconfig: 'core/tsconfig.json',
  test: {
    environment: 'node',
    include: ['core/tests/**/*.test.ts', 'syntax/tests/**/*.test.ts'],
  },
})
```

Also home for build helpers and smoke scripts (`tooling/relay-smoke.mjs`,
`tooling/local-checksum.mjs`). Run tests with
`vp test --config tooling/vite.config.ts`.

## Typed environment

Never read `process.env` / `import.meta.env` raw in app code. Declare the
whole surface once:

```ts
// env.ts
import { defineEnv, string } from 'void/env'

export default defineEnv({
  GITHUB_CLIENT_ID: string(),
  GITHUB_CLIENT_SECRET: string(),
  SESSION_SECRET: string(),
  OSDASH_CLEF_LOGINS: string().optional(),
})
```

Optional secrets are `.optional()`. Everything else fails fast when
missing.

## `shared/`

Pure logic used by more than one side (client and server, or app and
script) goes in `shared/`, one concept per file, test next to it:
`claim.ts` + `claim.test.ts`. No framework imports there. A file that needs
`useState` or `defineEventHandler` belongs in `app/` or `server/`.

`core/` is different: it holds the spec a repo owns and others generate
from (`lig` generates editor ports from `core/`). Only give a site a
`core/` when something outside the site consumes it.

## Script names

Name scripts `<area>:<verb>`, and let the bare verb mean the whole repo:

```
ports:generate   ports:check   ports:test   ports:typecheck
tokens:generate  tokens:check  tokens:test
build  dev  generate  preview  deploy  typecheck  lint  fmt  check
```

`check` is the aggregate gate. When a repo has generated artifacts,
`check` includes the `*:check` scripts so CI catches an un-regenerated
file.

`postinstall` is `nuxt prepare` on a Nuxt repo. `prepare` installs hooks.
`preview:deploy` deploys a preview build.

## `.gitignore` baseline

```
*.log  *.tgz  .cache  .DS_Store  .eslintcache  .idea
.env  .env.local  .env.*.local
.nuxt  .temp  .output  .vite  .turbo
.wrangler  .cloudflare  .void  .void-wrangler.jsonc
cache  coverage  dist  lib-cov  logs  node_modules  temp  .data
.ghfs
```

Add repo-specific ignores last, with a comment saying why (e.g.
`# Token-generated website downloads` / `/public/ports/`).

## Deploy target shape

A Cloudflare Worker app declares bindings and routes in `void.config.ts`
and keeps `cloudflare.config.ts` as the preview adapter. Both are
described in `froq-web-app`. The point here is that deploy config is data,
not a script with flags scattered across `package.json`.
