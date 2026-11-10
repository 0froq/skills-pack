# Lint and format

`vp` (vite-plus) drives both: `vp lint` runs oxlint, `vp fmt` runs oxfmt.
Two config files at repo root, nothing else.

## `.oxlintrc.json`

```json
{
  "plugins": ["typescript", "unicorn", "oxc", "vue"],
  "categories": { "correctness": "error" },
  "ignorePatterns": [".nuxt/**", ".output/**", "dist/**", ".agents/**", "vendor/ui/**"]
}
```

`plugins` on a Vue/Nuxt repo: `typescript`, `unicorn`, `oxc`, `vue`. Start
with only the `correctness` category at `error` — add categories when a
specific need shows up, not preemptively.

## `.oxfmtrc.json`

```json
{
  "semi": false,
  "singleQuote": true,
  "arrowParens": "avoid",
  "quoteProps": "consistent",
  "singleAttributePerLine": true,
  "htmlWhitespaceSensitivity": "strict"
}
```

Always ignore generated and vendored paths: `.nuxt/**`, `.output/**`,
`dist/**`, `public/**`, `vendor/ui/**`, `pnpm-lock.yaml`.
Ignore `AGENTS.md` and `docs/**` when prose is hand-formatted.

## Scripts

```json
{
  "lint": "vp lint --config .oxlintrc.json .",
  "lint:fix": "vp lint --config .oxlintrc.json . --fix",
  "fmt": "vp fmt --config .oxfmtrc.json .",
  "fmt:check": "vp fmt --config .oxfmtrc.json . --check",
  "check": "vp run lint && vp run fmt:check && vp run typecheck"
}
```

`check` is the one command to run before committing. Chain more gates into
it when a repo has them (token checks, generated-file checks).

## pre-commit

`lint-staged` with `vp lint --fix` and `vp fmt` on staged files,
after an offline frozen install. See `overrides.md`.

## Migrated repos

Repos still on ESLint (`@antfu/eslint-config`) keep `eslint.config.ts` and
`eslint . --cache` scripts until someone migrates them on purpose
(`vp migrate` handles most of it). Do not mix both tools in one repo.

## What lint no longer enforces

The ESLint setup could enforce pnpm catalog usage via
`pnpm/json-enforce-catalog`. oxlint has no equivalent rule. Catalog
discipline is now a convention plus review, not a lint error.
