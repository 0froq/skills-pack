---
name: froq-stack
description: froQ's toolchain choices and config file shapes for a repo — directory layout, lint/format, Nuxt, UnoCSS, pnpm catalogs, overrides. Use when creating a repo, adding those tools to an existing one, or deciding where code and config files go.
license: MIT
metadata:
  author: froQ
  version: "0.2.0"
  source: Hand-written from froQ repos, antfu/starter-ts, and voidzero-dev/vite-plus. https://github.com/0froq/skills-pack
---

# froq-stack

Config file shapes and tool picks. Answers "which files does this kind of
repo have and what goes in them". Does not answer "how code reads inside
those files" (`froq-code-style`) or "how a repo gets created"
(`froq-create-repo`).

## Repo forms

| Repo | Layout |
| --- | --- |
| TypeScript library published to npm | [references/library.md](references/library.md) |
| Nuxt app or static site | [references/site.md](references/site.md) |
| Multiple packages, or a toolchain with Rust crates | [references/monorepo.md](references/monorepo.md) |

## Config files

| Tool | Read |
| --- | --- |
| Lint and format (`vp lint` / `vp fmt`) | [references/lint-format.md](references/lint-format.md) |
| Nuxt | [references/nuxt.md](references/nuxt.md) |
| UnoCSS | [references/unocss.md](references/unocss.md) |

Catalogs, git hooks, source-shipping packages, sites, commits:
[references/overrides.md](references/overrides.md).

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

## Hand-offs

- Repo creation flow and one-time scaffolding: `froq-create-repo`
- In-file code conventions: `froq-code-style`
- Cloudflare deploy: `froq-web-app`
- README shapes: `froq-create-repo` → `references/readme/`
