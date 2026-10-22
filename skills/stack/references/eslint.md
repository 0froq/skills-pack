# ESLint

froQ **sites** use Oxlint, Oxfmt, and `vp` instead; see [lint-format.md](lint-format.md).

This file is for **published npm libraries** (`antfu/starter-ts` shape).

`eslint.config.ts`. `@antfu/eslint-config`. Catalog: `dev`.

```ts
import antfu from '@antfu/eslint-config'

export default antfu({
  pnpm: true,
  typescript: true,
  vue: true,
  rules: {
    'vue/max-attributes-per-line': ['error', {
      singleline: { max: 1 },
      multiline: { max: 1 },
    }],
    'unused-imports/no-unused-imports': 'off',
  },
  formatters: {
    css: true,
    html: true,
    markdown: 'dprint',
  },
})
```

Ignore `content/**`, `README.md`, and `vendor/ui/**` when a library vendors UI source.
dprint rewrites MDC `---` prop blocks. The vendored UI library has its own config.

`@froq/ui` limits the catalog rule to dev dependencies. Runtime ranges stay portable for `file:vendor/ui`:

```ts
{
  files: ['package.json'],
  rules: {
    'pnpm/json-enforce-catalog': ['error', { fields: ['devDependencies'] }],
  },
}
```

Do not set `unocss: true` unless the repo has `uno.config.ts`.
Node test files under `core/tests`, `syntax/tests`, and `ports` may turn off `test/no-import-node-test`.

Scripts: `lint` is `eslint . --cache`. `lint:fix` adds `--fix`.
pre-commit runs lint-staged `eslint --fix` after an offline frozen install.
