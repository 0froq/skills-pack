# Nuxt

Nuxt 4 layout: `app/` holds pages and components, `server/` holds routes.
`nuxt.config.ts` never carries lint or format config. That lives in
`vite.config.ts`.

## Modules

Content site:

```ts
modules: ['@nuxt/content', '@nuxtjs/i18n', '@nuxt/eslint']
```

`@nuxt/eslint` only while the repo is still on ESLint. Under `vp lint`
there is no Nuxt module to add.

## CSS order

The UI library and the three faces come first, app styles after:

```ts
css: [
  '@froq/ui/style.css',
  '@fontsource-variable/geist/index.css',
  '@fontsource-variable/geist-mono/index.css',
  '@fontsource/instrument-serif/400.css',
  '@fontsource/instrument-serif/400-italic.css',
]
```

`build.transpile` includes `@froq/ui`.

Fonts are three stacks declared in `tokens.css`: display (Instrument
Serif), text (Geist), meta (Geist Mono). Do not add a fourth without a
reason. See `froq-design`.

## i18n

`en` and `zh`, default `en`, strategy `prefix_except_default`,
`detectBrowserLanguage: false`.

## Vendor alias

When `@froq/ui` is vendored at `vendor/ui`, alias the package name at the
vendored source in `nuxt.config.ts`, including `style.css` and
`tokens.css`. See `site.md`. `lig` also aliases the library's own
dependencies (`reka-ui`, `@internationalized/date`) out of the installed
copy so pnpm resolves them. Do the same when a vendored library pulls
runtime deps.

## Other config

- `compatibilityDate` pinned to a date, not omitted.
- `extends` for a shared layer (e.g. `@froq/og-covers-layer`).
- Generated artifacts (tokens, ports, palettes) are produced by a
  `*:generate` script and checked by a `*:check` script chained into
  `check`. Never hand-edit the generated file.

## Deploy

Nitro preset and the deploy command are in `froq-web-app`. A site does not
add UnoCSS (`unocss.md`) and does not add `tsdown` or `knip`.
