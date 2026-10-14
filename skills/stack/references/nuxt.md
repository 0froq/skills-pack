# Nuxt

`nuxt.config.ts`. Modules on a content site:

```ts
modules: [
  '@nuxt/content',
  '@nuxtjs/i18n',
  '@nuxt/eslint',
]
```

CSS starts with the UI library and the three faces:

```ts
css: [
  '@froq/ui/style.css',
  '@fontsource-variable/geist/index.css',
  '@fontsource-variable/geist-mono/index.css',
  '@fontsource/instrument-serif/400.css',
  '@fontsource/instrument-serif/400-italic.css',
]
```

Add the app's own styles after those.
`build.transpile` includes `@froq/ui`.

i18n: `en` and `zh`. Default `en`. Strategy `prefix_except_default`. `detectBrowserLanguage: false`.

Do not add `@unocss/nuxt` on a new site. See [unocss.md](unocss.md).
Nitro preset and the deploy command are in the `cloudflare-sites` skill.
