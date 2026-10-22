# Lint and format (sites)

froQ product sites follow [0froq/lig](https://github.com/0froq/lig). They use **Oxlint**, **Oxfmt**, and **[vite-plus](https://github.com/voidzero-dev/vite-plus)** (`vp`), not ESLint or `@nuxt/eslint`.

Config at the repo root:

- `.oxlintrc.json`
- `.oxfmtrc.json`

Scripts pass config paths explicitly (do not rely on vite-plus auto-discovery):

```json
"lint": "vp lint --config .oxlintrc.json .",
"lint:fix": "vp lint --config .oxlintrc.json . --fix",
"fmt": "vp fmt --config .oxfmtrc.json .",
"fmt:check": "vp fmt --config .oxfmtrc.json . --check",
"check": "vp run lint && vp run fmt:check && vp run typecheck",
"typecheck": "nuxt typecheck"
```

`vite-plus` is a devDependency in the catalog. Use `vp run <script>` for orchestration and `vp test` with `tooling/vite.config.ts` when the site has non-UI tests.

pre-commit installs with `pnpm i --frozen-lockfile --ignore-scripts --offline`, then lint-staged runs oxlint and oxfmt through `vp`:

```json
"lint-staged": {
  "*": [
    "vp lint --config .oxlintrc.json --fix --no-error-on-unmatched-pattern",
    "vp fmt --config .oxfmtrc.json --no-error-on-unmatched-pattern"
  ]
}
```

Do not format `vendor/ui/**`, generated files, or MDC content trees that the project excludes from its baseline. The vendored UI library keeps its own upstream rules.

Published npm libraries still use ESLint; see [eslint.md](eslint.md).
