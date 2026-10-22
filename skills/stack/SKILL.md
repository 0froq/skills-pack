---
name: stack
description: >-
  Lay out a froQ repo and write its Nuxt, Oxlint/Oxfmt (vite-plus), ESLint
  (libraries), and UnoCSS config. Use when creating a repository, adding those
  tools, or deciding where code and config files go.
metadata:
  author: froQ
  version: "2026.10.22"
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
| 站点 lint / format（lig 标准） | [references/lint-format.md](references/lint-format.md) |
| 发 npm 的库（ESLint） | [references/eslint.md](references/eslint.md) |
| Nuxt | [references/nuxt.md](references/nuxt.md) |
| UnoCSS | [references/unocss.md](references/unocss.md) |

catalog、钩子、发源码的库，见 [references/overrides.md](references/overrides.md)。
README 在 `repo-face`。Cloudflare 发布在 `cloudflare-sites`。

## 上游

[antfu/starter-ts](https://github.com/antfu/starter-ts) 是要发 npm 的库的目录。
[voidzero-dev/vite-plus](https://github.com/voidzero-dev/vite-plus) 在 monorepo 里是 `packages/` 加 Rust `crates/`。
froQ 站点（lig）用其中的 `vp` 跑 oxlint、oxfmt 和测试；不要把 Cargo 或 devcontainer 抄进普通站点或库。
站点模板见 [0froq/lig](https://github.com/0froq/lig)。
