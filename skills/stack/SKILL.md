---
name: stack
description: >-
  Lay out a froQ repo and write its Nuxt, vite-plus / @liangmi/vp-config
  (Oxlint, Oxfmt), ESLint (legacy libraries), and UnoCSS config.
  Use when creating a repository, adding those tools, or deciding where
  code and config files go.
metadata:
  author: froQ
  version: "2026.10.26"
  source: Hand-written from froQ repos, antfu/starter-ts, voidzero-dev/vite-plus, and liangmiQwQ/vp-config. https://github.com/0froq/skills-pack
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
| 新站 / 迁站 lint·format | [references/vp-config.md](references/vp-config.md) |
| ESLint（遗留；发 npm 的库） | [references/eslint.md](references/eslint.md) |
| Nuxt | [references/nuxt.md](references/nuxt.md) |
| UnoCSS | [references/unocss.md](references/unocss.md) |

catalog、钩子、发源码的库，见 [references/overrides.md](references/overrides.md)。
README 在 `repo-face`。Cloudflare 发布在 `cloudflare-sites`（`cf`，不用 wrangler CLI）。

## 上游

[antfu/starter-ts](https://github.com/antfu/starter-ts) 是要发 npm 的库的目录。
[voidzero-dev/vite-plus](https://github.com/voidzero-dev/vite-plus) 在它自己的仓库里是 `packages/` 加 Rust `crates/`。不要把 Cargo 或 devcontainer 抄进网站或普通库。
froQ 站点用其中的 `vp`（lint / fmt / check），配置走 [`@liangmi/vp-config`](https://github.com/liangmiQwQ/vp-config) 的 `liangmi()`，见 [vp-config.md](references/vp-config.md)。
[0froq/lig](https://github.com/0froq/lig) 迁完之后是站点样板。
