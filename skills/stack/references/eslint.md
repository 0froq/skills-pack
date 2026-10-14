# ESLint

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

A Nuxt app appends the generated config:

```ts
import antfu from '@antfu/eslint-config'
import nuxt from './.nuxt/eslint.config.mjs'

export default antfu({ /* same options */ }).append(nuxt())
```

Ignore `content/**`, `README.md`, and `vendor/ui/**`.
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
