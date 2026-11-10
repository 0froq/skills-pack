---
name: froq-code-style
description: froQ's coding conventions for JavaScript and TypeScript. Use for file layout inside a module, imports, types, tests, catalogs, and releases. Tool config files (oxlint/oxfmt, Nuxt, UnoCSS) live in froq-stack; one-time repo scaffolding lives in froq-create-repo.
license: MIT
metadata:
  author: froQ
  version: "0.2.0"
  source: Hand-written. https://github.com/0froq/skills-pack
---

# froq-code-style

How code reads inside a froQ repo. Covers practices inside source files and
package-level conventions (scripts, catalogs, releases). Does not cover tool
config file shapes (`froq-stack`) or one-time scaffolding files
(`froq-create-repo`).

## Coding Practices

### Code Organization

- **Single responsibility**: each source file has a clear, focused scope
- **Split large files**: break files when they grow or take on extra concerns
- **Type separation**: keep types and interfaces in `types.ts` or `types/*.ts`
- **Constants extraction**: move constants to a dedicated `constants.ts`

### Runtime Environment

- Prefer isomorphic code that runs in Node, browser, and workers
- When code is environment-specific, mark it at the top of the file:

```ts
// @env node
// @env browser
```

### Explicitness

Explicit, traceable code over implicit magic. A reader (human or agent)
should follow where every name comes from without running tooling.

- **Explicit imports everywhere.** No auto-import reliance: call custom
  composables/utils through real `import` statements, not framework runtime
  resolution. Framework conventions (`composables/`, `components/`
  directories) still apply, but importing is explicit.
- **No path aliases.** Use relative imports (`./foo`, `../bar`). Do not add
  `paths` mappings or `@/`/`~/` aliases. Workspace package-name aliases
  inside a monorepo (`@myorg/core`) are fine — those are package names,
  not path aliases.

### TypeScript

- **Explicit return types** when possible
- **Extract complex inline types** into `type`/`interface` declarations

### Comments

- Code should be self-explanatory; comments explain "why", not "how"

### Testing (Vitest)

- Test files: `foo.ts` → `foo.test.ts`, same directory
- `describe`/`it` API, not `test`
- `toMatchSnapshot` for complex outputs, `toMatchFileSnapshot` with explicit
  path for language-specific snapshots

---

## Package Conventions

### Commands

`vp` (vite-plus) is the toolchain shell where a repo has migrated to it;
`@antfu/ni` commands (`ni`, `nr`, `nu`, `nun`, `nci`, `nlx`) elsewhere.
pnpm is the package manager underneath either way.

### Checking npm package versions

Use [`fast-npm-meta`](https://github.com/antfu/fast-npm-meta) instead of
`npm view` — one metadata call, not the full registry payload:

```bash
nlx fast-npm-meta version vite              # latest version
nlx fast-npm-meta version "nuxt@^3.5"       # range-aware
nlx fast-npm-meta version vite nuxt vue     # multiple at once
```

### Knip

Use [Knip](https://knip.dev) to catch unused files, exports, and
dependencies — linters see one file at a time, Knip sees the graph:

```json
// knip.json
{ "$schema": "https://unpkg.com/knip@6/schema.json", "project": ["src/**/*.ts"] }
```

Fix reports by deleting; use `ignoreDependencies` only for tools invoked
outside package.json scripts.

### The `ci` gate

Every repo exposes one `ci` script that runs all checks in a single
command (lint + format check + typecheck + knip + tests). Run it before
committing; do not commit on a failing `ci` — fix the cause, not the rule.

### Git hooks

Pre-commit runs lint and format on staged files. The tool varies per repo
(`vp staged`, `lint-staged`); the rule does not.

### TypeScript config

```json
{
  "compilerOptions": {
    "target": "ESNext", "module": "ESNext", "moduleResolution": "bundler",
    "strict": true, "esModuleInterop": true, "skipLibCheck": true,
    "resolveJsonModule": true, "isolatedModules": true, "noEmit": true
  }
}
```

No `paths`, no `baseUrl` aliases.

### pnpm catalogs

Named catalogs in `pnpm-workspace.yaml` for version management:

| Catalog | Purpose |
|---------|---------|
| `prod` | Production dependencies |
| `inlined` | Bundler-inlined dependencies |
| `dev` | Dev tools (linter, bundler, testing) |
| `frontend` | Frontend libraries |

Never the default catalog. Names adjust per project.

## Boundaries

- No auto-import reliance in business code (see Explicitness)
- No path aliases
- No `any` unless justified in a comment
- No committing with a failing `ci`

## Hand-offs

- Tool config files (oxlint/oxfmt, Nuxt, UnoCSS, catalog YAML): `froq-stack`
- One-time repo files (.gitignore, GHA workflows, base package.json):
  `froq-create-repo` → `references/setting-up.md`
- Repo creation decision flow: `froq-create-repo`
- Cloudflare deploy specifics: `froq-web-app`

## References

| Topic | Description | Reference |
|-------|-------------|-----------|
| pnpm Catalog | Named catalogs, protocol, migration | [pnpm-catalog](references/pnpm-catalog.md) |
| Release Workflow | changelogithub, tags, OIDC publishing | [release-workflow](references/release-workflow.md) |
| App Development | Vue/Nuxt/UnoCSS conventions | [app-development](references/app-development.md) |
| Monorepo | Workspaces, package naming, build order | [monorepo](references/monorepo.md) |
| Library Development | tsdown, pure ESM, exports | [library-development](references/library-development.md) |
