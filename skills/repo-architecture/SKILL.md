---
name: repo-architecture
description: >-
  Choose directory layout, package boundaries, and scripts for a froQ repo.
  Use when creating a repository, splitting a package, or deciding how a
  library, site, or monorepo should be structured. Applies recent antfu and
  VoidZero layout, then froQ's own overrides.
metadata:
  author: froQ
  version: "2026.10.14"
  source: Hand-written from antfu/starter-ts, voidzero-dev/vite-plus, and froQ repos. https://github.com/0froq/skills-pack
---

先判断仓库是哪一种，再读对应的一份 reference。不要把一种仓库的目录套到另一种上。

| 仓库 | 读 |
| --- | --- |
| 要发布到 npm 的 TypeScript 库 | [references/library.md](references/library.md) |
| Nuxt 或静态站 | [references/site.md](references/site.md) |
| 多个 package，或带 Rust crate 的工具链 | [references/monorepo.md](references/monorepo.md) |

froQ 和上游不一致的地方在 [references/overrides.md](references/overrides.md)。两边冲突时，froQ 的仓库用 overrides。

ESLint、UnoCSS、catalog 的细则在 `oq`。README 在 `repo-face`。Cloudflare 发布在 `cloudflare-sites`。这里不重复。

## 看过的上游

库的当前模板是 [antfu/starter-ts](https://github.com/antfu/starter-ts)（2026-10）。
单包也写 `pnpm-workspace.yaml`，用命名 catalog。构建用 tsdown。检查集中在一个 `ci` script。CI 复用 [sxzz/workflows](https://github.com/sxzz/workflows) 的 `unit-test.yml`。

工具链仓库的当前样子是 [voidzero-dev/vite-plus](https://github.com/voidzero-dev/vite-plus)。
`packages/` 放 JS，`crates/` 放 Rust，任务入口是 `vp` 和 `justfile`。
[vueuse](https://github.com/vueuse/vueuse) 仍是 `packages/` 加大仓，但它不是这份模板的更新来源。

不要把 vite-plus 的 Cargo、`vp`、devcontainer 抄进一个网站或一个普通库。
