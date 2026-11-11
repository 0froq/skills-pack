# Lint and format

Two tools under one shell: `vp lint` runs oxlint, `vp fmt` runs oxfmt.
Config is composed with [`oxlint-flat-config`](https://github.com/liangmiQwQ/oxlint-flat-config)
(`oxlint-flat-config/vite-plus` entry), so the config is an ESLint-style
array instead of one JSON object.

## Config lives in `vite.config.ts`

No `.oxlintrc.json`, no `.oxfmtrc.json`. The `lint` and `fmt` blocks hold
everything:

```ts
import { defineConfig, globalIgnores, recommended } from 'oxlint-flat-config/vite-plus'

export default defineConfig({
  fmt: {
    semi: false,
    singleQuote: true,
    arrowParens: 'avoid',
    singleAttributePerLine: true,
  },
  lint: [
    globalIgnores(['dist', 'coverage', 'vendor/ui']),
    recommended,
    { name: 'base', rules: { 'no-console': 'warn' } },
    { name: 'tests', files: ['**/*.test.ts'], rules: { 'no-console': 'off' } },
  ],
})
```

Import `defineConfig` from `oxlint-flat-config/vite-plus`, not `vite-plus` —
that is what makes `lint` take a flat array. Everything else is passed to
Vite+ unchanged. Do not install `oxlint`; Vite+ ships its own copy.

## Composing rules

Config objects apply in order, later overrides earlier. Nested arrays
flatten, falsy entries are skipped.

| Kind | Recognized by | Becomes |
| --- | --- | --- |
| Global ignores | only `ignores` / `name` / `basePath` | `ignorePatterns` |
| Global config | no `files`, no `basePath` | `settings` / `options` root, rest in a `**/*` override |
| Scoped config | has `files` or `basePath` | one `overrides` entry |

Two fields you may expect are absent on purpose:

- **No `categories`** — use the `category()` helper, e.g.
  `category({ correctness: 'error' })`.
- **No `plugins`** — every built-in oxlint plugin is enabled.

`settings` and `options` are root-only; a scoped config cannot set them.
Paths in `files`/`ignores` are relative to `vite.config.ts`.

## Monorepo

`vp check` always uses the `lint` block of the workspace root config, and
Vite+ disables nested lint configs. In a monorepo, express per-package
differences in the root config with `files` or `basePath` — not with a
`lint` block in each package.

## Scripts

```json
{
  "lint": "vp lint",
  "lint:fix": "vp lint --fix",
  "fmt": "vp fmt",
  "fmt:check": "vp fmt --check",
  "check": "vp run lint && vp run fmt:check && vp run typecheck"
}
```

`check` is the one command to run before committing. Chain extra gates
into it when a repo has them.

## pre-commit

`lint-staged` running `vp lint --fix` and `vp fmt` on staged files, after
an offline frozen install. See `overrides.md`.

## Repos without Vite+

Use `oxlint.config.ts` at repo root and import `defineConfig` from
`oxlint-flat-config` (no `/vite-plus` suffix). Same array API, but no
`fmt` block — oxfmt has its own config. Use `oxfmt.config.ts` (or
`.oxfmtrc.json`); both are auto-discovered, and TS keeps the two files in
the same style.

## Migrated repos

Repos still on ESLint (`@antfu/eslint-config`) keep `eslint.config.ts` and
`eslint . --cache` scripts until someone migrates them on purpose. Do not
mix ESLint and oxlint in one repo.

## What lint no longer enforces

The ESLint setup could enforce pnpm catalog usage via
`pnpm/json-enforce-catalog`. That was an `eslint-plugin-pnpm` rule with no
oxlint equivalent. Loading it back needs `jsPlugins`, which oxlint still
marks alpha. Catalog discipline is a convention plus review now, not a
lint error.
