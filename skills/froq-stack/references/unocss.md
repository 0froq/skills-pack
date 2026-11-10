# UnoCSS

New sites style with `@froq/ui` and plain CSS.
Do not add UnoCSS to them.

`0froq.github.io` still has UnoCSS: `@unocss/nuxt`, `unocss`, and `@unocss/extractor-mdc`.
Leave that config in place. Do not copy it into `lig`, `ui`, or `1000-observations`.

When a repo already has `uno.config.ts`, ESLint may set `unocss: true`.
A repo without that file does not.
