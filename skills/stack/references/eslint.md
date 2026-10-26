# ESLint (legacy)

froQ **sites** do not use ESLint. Prefer vite-plus + `@liangmi/vp-config`; see [vp-config.md](vp-config.md).

This file is only for **published npm libraries** that still follow `antfu/starter-ts`, and for sites that have not migrated yet. Do not add a new `eslint.config.ts` to a Nuxt or static site.

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

A legacy Nuxt app that is still on ESLint appends the generated config. New sites skip this and drop `@nuxt/eslint`:

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
