---
name: stack
description: >-
  Lay out a froQ repo and write its Nuxt, ESLint, and UnoCSS config.
  Use when creating a repository, adding those tools, or deciding where
  code and config files go.
metadata:
  author: froQ
  version: "2026.10.14"
  source: Hand-written from froQ repos, antfu/starter-ts, and voidzero-dev/vite-plus. https://github.com/0froq/skills-pack
---

先判断仓库是哪一种，再读对应的目录说明和要用的配置。

| 仓库 | 目录 |
| --- | --- |
| 要发布到 npm 的 TypeScript 库 | [references/library.md](references/library.md) |
| Nuxt 或静态站 | [references/site.md](references/site.md) |
| 多个 package，或带 Rust crate 的工具链 | [references/monorepo.md](references/monorepo.md) |

配置：

| 工具 | 读 |
| --- | --- |
| ESLint | [references/eslint.md](references/eslint.md) |
| Nuxt | [references/nuxt.md](references/nuxt.md) |
| UnoCSS | [references/unocss.md](references/unocss.md) |

catalog、钩子、发源码的库，见 [references/overrides.md](references/overrides.md)。
README 在 `repo-face`。Cloudflare 发布在 `cloudflare-sites`。

## 上游

[antfu/starter-ts](https://github.com/antfu/starter-ts) 是要发 npm 的库的目录。
[voidzero-dev/vite-plus](https://github.com/voidzero-dev/vite-plus) 是 `packages/` 加 Rust `crates/`。
不要把 Cargo、`vp`、devcontainer 抄进网站或普通库。
