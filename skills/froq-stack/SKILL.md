---
name: froq-stack
description: froQ's toolchain, repo layouts, and config file shapes — directories, runtime pinning, tsconfig, lint/format, Nuxt, UnoCSS, pnpm catalogs, scaffolding. Use when creating a repo, adding a tool, or deciding where code and config files go.
license: MIT
metadata:
  author: froQ
  version: "0.3.0"
  source: Hand-written from froQ repos, antfu/starter-ts, and voidzero-dev/vite-plus. https://github.com/0froq/skills-pack
---

# froq-stack

Config shapes and tool picks. Answers "which files does this kind of repo
have, and what goes in them". Does not answer "how code reads inside those
files" (`froq-code-style`) or "how a repo gets created"
(`froq-create-repo`).

## Repo forms

| Repo | Layout |
| --- | --- |
| TypeScript library published to npm | [references/library.md](references/library.md) |
| Nuxt app or static site | [references/site.md](references/site.md) |
| Multiple packages, or a toolchain with Rust crates | [references/monorepo.md](references/monorepo.md) |
| Starting a new repo | [references/scaffolding.md](references/scaffolding.md) |

## Every repo

| Concern | Read |
| --- | --- |
| Node/pnpm pinning, tsconfig, `tooling/`, typed env, `shared/`, script names, `.gitignore` | [references/runtime.md](references/runtime.md) |
| Catalogs, git hooks, source-shipping packages, commits | [references/overrides.md](references/overrides.md) |

## Config by tool

| Tool | Read |
| --- | --- |
| Lint and format (`vp lint` / `vp fmt`) | [references/lint-format.md](references/lint-format.md) |
| Nuxt | [references/nuxt.md](references/nuxt.md) |
| UnoCSS | [references/unocss.md](references/unocss.md) |

## Taste in one screen

The short version of what the references expand:

- **Config is data, not flags.** Bindings, routes, catalogs, and lint rules
  live in a config file; `package.json` scripts stay short verbs.
- **One source per fact.** Breakpoints in one module, versions in catalogs,
  env in `env.ts`, tool config in `tooling/` when a framework owns the root.
- **Explicit over implicit.** No path aliases, no auto-import reliance, no
  default (unnamed) catalog, no hand-edited generated files.
- **Generated things are checked.** Any `*:generate` script has a
  `*:check` twin wired into `check`.
- **Three font stacks, three breakpoints.** Display/text/meta faces, and
  `sm`/`md`/`lg` only. Extension needs a reason.
- **Pin, then don't chase.** Node and pnpm are pinned in three places and
  bumped on purpose, never to match a template.

## Upstream references

[antfu/starter-ts](https://github.com/antfu/starter-ts) is the layout for a
library published to npm.
[voidzero-dev/vite-plus](https://github.com/voidzero-dev/vite-plus) is
`packages/` plus Rust `crates/`. Do not copy Cargo, `vp`, or devcontainers
into a site or a plain library.

## Boundaries

- No copying a Rust toolchain layout into a JS-only repo.
- No Turborepo until pnpm filters are demonstrably too slow.
- No UnoCSS on new sites; `@froq/ui` plus plain CSS.
- No mixing ESLint and oxlint in one repo.
- No default `catalog:` entries — every version has a category.
- No hand-edited generated files.

## Hand-offs

- Repo creation flow and one-time scaffolding: `froq-create-repo`
- In-file code conventions: `froq-code-style`
- Design direction and token discipline: `froq-design`
- Cloudflare deploy: `froq-web-app`
- README shapes: `froq-create-repo` → `references/readme/`
