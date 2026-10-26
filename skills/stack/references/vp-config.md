# vite-plus + vp-config

New and migrating froQ **sites** use [vite-plus](https://github.com/voidzero-dev/vite-plus) (`vp`) with [`@liangmi/vp-config`](https://github.com/liangmiQwQ/vp-config). Lint is an [oxlint-flat-config](https://github.com/liangmiQwQ/oxlint-flat-config) array inside `liangmi()`. Do not add ESLint, `@antfu/eslint-config`, or `@nuxt/eslint`.

Upstream READMEs are the source of truth for the APIs. [0froq/lig](https://github.com/0froq/lig) is the site gold standard once it has migrated to this preset. lig main today still uses root `.oxlintrc.json` / `.oxfmtrc.json` and `tooling/vite.config.ts` — that is transitional; do not copy it for a new site.

Published npm libraries still use ESLint; see [eslint.md](eslint.md).

## Install

Catalog `dev`:

```bash
pnpm add -D vite-plus @liangmi/vp-config
```

Do not install `oxlint`. Vite+ ships it. `oxlint-flat-config` is a dependency of the preset; import it only if you compose extra lint objects yourself.

Requires `vite-plus@1.0.0` or later. Pin Node **24.21** (`.node-version` / `engines`: `^24.21.0`). Workers Builds `NODE_VERSION=24.21.0`. Deploy is `cf`, not the wrangler CLI — see the `cloudflare-sites` skill.

Optional agent helper for a generic vp-config migration: `npx skills add liangmiQwQ/vp-config`. This file is the froQ site overlay on top of that.

## Root `vite.config.ts`

Vite+ only reads `lint` and `fmt` from the **workspace root**. Nuxt still owns the app Vite (`nuxt.config.ts`, `nuxt dev`, `nuxt generate`). Put tooling in a root `vite.config.ts` anyway. Do not run `vp dev`, `vp build`, or `vp pack` for a Nuxt site.

```ts
import { liangmi } from '@liangmi/vp-config'

export default liangmi({
  lint: [
    { ignores: ['vendor/**', 'content/**', '**/generated/**'] },
  ],
  fmt: {
    ignorePatterns: [
      'vendor/**',
      'content/**',
      '**/generated/**',
      'public/**',
    ],
  },
}).only(['lint', 'fmt', 'run', 'staged'])
```

`.only` keeps the preset from treating the Nuxt app as something to pack or serve. Include `'test'` in that list when non-UI tests should run through the same config.

lig today keeps `vp test` in `tooling/vite.config.ts` so Nuxt is not involved. After migration, lint/fmt must live in the root `liangmi()` call. Tests may stay `vp test --config tooling/vite.config.ts`, or move into root `test`.

`liangmi()` already wraps `defineConfig`. Do not wrap it again. User `lint` objects are appended after the preset (later wins). `fmt` is deeply merged.

## Lint (flat config)

`lint` is an ESLint-style flat array from oxlint-flat-config, not an Oxlint root object. Paths in `files` / `ignores` are relative to the workspace root.

To change named preset objects, chain composer methods on `liangmi()`: `append`, `prepend`, `insertBefore`, `insertAfter`, `override`, `replace`, `remove`, `overrideRules`, `removeRules`.

```ts
export default liangmi({})
  .override('liangmi/options', { options: { typeCheck: false } })
  .remove('liangmi/style')
```

| Name | |
| --- | --- |
| `liangmi/ignores` | Global ignores |
| `liangmi/options` | `typeAware`, `typeCheck`, `denyWarnings` |
| `liangmi/correctness`, `liangmi/perf`, `liangmi/suspicious`, `liangmi/nursery` | Whole categories (plugin-prefixed names, e.g. `eslint/no-debugger`) |
| `liangmi/restriction`, `liangmi/pedantic`, `liangmi/style` | Selected rules (mostly unprefixed, e.g. `no-console`) |
| `liangmi/node`, `liangmi/browser`, `liangmi/cli`, `liangmi/react`, `liangmi/vue` | Traits from committed files |
| `liangmi/test`, `liangmi/script`, `liangmi/config-file` | File roles |

Vue template linting is still incomplete upstream. Do not bring `@nuxt/eslint` back for that.

Only `oxlint-disable` comments count. Convert `eslint-disable`. Unused disables warn, and warnings fail (`denyWarnings`).

Always ignore `vendor/**`, Nuxt Content trees (`content/**`), and generated output. The vendored UI library keeps its own rules.

## Format

The preset sets Oxfmt: single quotes, no semicolons, no trailing commas, sorted imports. React/Vue turn on embedded-language formatting. Do not add a root `.oxfmtrc.json` on a new site.

Merge extra `fmt.ignorePatterns` as above. Do not format `vendor/**`, content, public assets, or generated files.

## Scripts

Cached tasks from the preset (`vp run clint` is `vp lint` with the task cache):

```json
{
  "lint": "vp run clint",
  "fmt": "vp run cfmt",
  "check": "vp run ccheck && nuxt typecheck",
  "postinstall": "nuxt prepare"
}
```

`ccheck` is `vp check` (lint + format check + oxlint typeCheck). Keep `nuxt typecheck` for Vue SFCs. If oxlint typeCheck fails because `.nuxt` types are missing, override `liangmi/options` to `{ typeCheck: false }` and keep `nuxt typecheck`.

Plain `vp lint` / `vp fmt` / `vp fmt --check` are fine when you do not need the cache wrappers.

`dev` / `generate` stay Nuxt. `deploy` / `preview:deploy` stay `pnpm generate && cf …` — `cloudflare-sites`.

## Hooks

Keep froQ pre-commit: frozen offline install, then lint-staged. Point lint-staged at `vp`, not ESLint:

```json
{
  "simple-git-hooks": {
    "pre-commit": "pnpm i --frozen-lockfile --ignore-scripts --offline && npx lint-staged"
  },
  "lint-staged": {
    "*": [
      "vp lint --fix --no-error-on-unmatched-pattern",
      "vp fmt --no-error-on-unmatched-pattern"
    ]
  },
  "scripts": {
    "prepare": "npx simple-git-hooks"
  }
}
```

Do not replace that with nano-staged or `pnpm run ci`. The preset's `staged` + `vp config` is optional; do not drop the frozen install to use it.

## Migrate a site off ESLint

1. Add `vite-plus` and `@liangmi/vp-config` to catalog `dev`.
2. Remove `eslint`, `@antfu/eslint-config`, `@nuxt/eslint`, `eslint-plugin-format`, `dprint` if it only served ESLint markdown, and `eslint.config.ts`.
3. Drop `@nuxt/eslint` from `nuxt.config.ts` `modules`.
4. Write root `vite.config.ts` with `liangmi({...})` as above.
5. Delete `.oxlintrc.json` / `.oxfmtrc.json` if the site had the lig transitional files.
6. Switch `lint` / `fmt` / `check` and lint-staged to `vp`.
7. Pin Node 24.21. Convert remaining `eslint-disable` comments.
8. Deploy through `cloudflare-sites` (`cf`, not wrangler CLI).

Do not copy Cargo, `justfile`, or a `vp` wrapper that replaces `pnpm` from `voidzero-dev/vite-plus`.
