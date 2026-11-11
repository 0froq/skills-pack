# UnoCSS

Default for a new froQ site: `@froq/ui` plus plain CSS. Do not add UnoCSS
to it.

Existing sites keep it. `0froq.github.io` runs `uno.config.mts`, `feeds`
runs `uno.config.ts`. Keep those configs where they are; do not copy them
into `lig`, `ui`, or a new project.

## Shape

```ts
import {
  defineConfig,
  presetAttributify,
  presetIcons,
  presetTagify,
  presetTypography,
  presetWind4,
  transformerDirectives,
  transformerVariantGroup,
} from 'unocss'

export default defineConfig({
  theme: {
    breakpoint: { sm: `${sm}px`, md: `${md}px`, lg: `${lg}px` },
    colors: tokenColors(),   // from tokens.css
    font: tokenFonts(),      // from tokens.css
  },
  presets: [
    presetWind4(),
    presetIcons({ /* see below */ }),
    presetTypography({ /* see below */ }),
  ],
  transformers: [transformerDirectives(), transformerVariantGroup()],
})
```

## Breakpoints: three, no more

Only `sm`, `md`, `lg`. Do not add `xl`, `2xl`, or extra pixel cuts. Width
responsive utilities are `sm:` `md:` `lg:` `max-sm:` `max-md:` `max-lg:`
and nothing else. Keep the numbers in one file (`app/utils/breakpoints.ts`
in `0froq.github.io`) and read them into `theme.breakpoint` — do not
repeat literals in config and components.

## Tokens bridge, never raw colors

`theme.colors` and `theme.font` come from `tokens.css` through a small
`uno.tokens.ts` adapter. A color literal in `uno.config` is a dark-mode bug
waiting to happen, same rule as `froq-design`.

`presetTypography` follows the same rule: every `colorScheme` key maps to
a CSS variable rather than a hex value.

```ts
presetTypography({
  colorScheme: {
    body: ['var(--ink)', 'var(--ink)'],
    lead: ['var(--muted)', 'var(--muted)'],
    'hr': ['var(--line)', 'var(--line)'],
    'pre-bg': [
      'color-mix(in srgb, var(--ink) 6%, var(--paper))',
      'color-mix(in srgb, var(--ink) 6%, var(--paper))',
    ],
  },
})
```

## Icons

`presetIcons` with `scale: 1.2` and inline alignment:

```ts
presetIcons({
  scale: 1.2,
  extraProperties: { display: 'inline-block', 'vertical-align': '-0.125em' },
  collections: {
    carbon: () => import('@iconify-json/carbon/icons.json', { with: { type: 'json' } }).then(i => i.default),
    // one lazy loader per collection actually used
  },
})
```

Declare only the collections in use, each as a lazy import, so icons stay
out of the initial bundle. `feeds` uses `autoInstall: true` with the
collection list commented out — fine for a site that does not care about
bundle size.

## Safelist

Classes composed dynamically (string concat, runtime keys) must be listed
in `safelist`, or they never get generated:

```ts
safelist: ['w-6', 'h-6', 'i-openmj-thumbs-up?bg'],
```

Keep it short and comment why an entry exists. A long safelist usually
means the class name should be static instead.

## Classes versus attributify

Write utilities in `class` attributes (`froq-design` / `froq-code-style`
rule). `0froq.github.io` still carries `presetAttributify` with
`prefix: 'un-'`, `prefixedOnly: true`, `strict: true` — that config stays
as-is for the existing markup, but new markup in any repo uses `class`.
Do not add attributify to a new project.

## Content scan

Cover file types the pipeline misses:

```ts
content: {
  filesystem: ['app/assets/css/**/*.css'],
  pipeline: {
    include: [/\.(vue|svelte|[jt]sx|mdx?|astro|html|css)($|\?)/],
  },
},
```

An MDC site also needs `@unocss/extractor-mdc` in `extractors`.

## Modules

Nuxt: `@unocss/nuxt` plus `unocss` and, for MDC, `@unocss/extractor-mdc`.
UnoCSS needs no extra lint config under `vp lint`. A repo without a
`uno.config.ts` simply has no UnoCSS.
