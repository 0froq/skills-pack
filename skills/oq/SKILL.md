---
name: oq
description: oQ's coding conventions for JavaScript and TypeScript. Use for file layout inside a module, types, tests, pnpm catalogs, and releases. Directory choice and Nuxt, ESLint, and UnoCSS files live in the stack skill.
metadata:
  author: oQ
  version: "2026.03.10"
  source: Hand-written. https://github.com/0froq/skills-pack
---

## Coding Practices

### Code Organization

- **Single responsibility**: Each source file should have a clear, focused scope/purpose
- **Split large files**: Break files when they become large or handle too many concerns
- **Type separation**: Always separate types and interfaces into `types.ts` or `types/*.ts`
- **Constants extraction**: Move constants to a dedicated `constants.ts` file

### Runtime Environment

- **Prefer isomorphic code**: Write runtime-agnostic code that works in Node, browser, and workers whenever possible
- **Clear runtime indicators**: When code is environment-specific, add a comment at the top of the file:

```ts
// @env node
// @env browser
```

### TypeScript

- **Explicit return types**: Declare return types explicitly when possible
- **Avoid complex inline types**: Extract complex types into dedicated `type` or `interface` declarations

### Comments

- **Avoid unnecessary comments**: Code should be self-explanatory
- **Explain "why" not "how"**: Comments should describe the reasoning or intent, not what the code does

### Testing (Vitest)

- Test files: `foo.ts` → `foo.test.ts` (same directory)
- Use `describe`/`it` API (not `test`)
- Use `toMatchSnapshot` for complex outputs
- Use `toMatchFileSnapshot` with explicit path for language-specific snapshots

---

## Tooling Choices

### @antfu/ni Commands

| Command | Description |
|---------|-------------|
| `ni` | Install dependencies |
| `ni <pkg>` / `ni -D <pkg>` | Add dependency / dev dependency |
| `nr <script>` | Run script |
| `nu` | Upgrade dependencies |
| `nun <pkg>` | Uninstall dependency |
| `nci` | Clean install (`pnpm i --frozen-lockfile`) |
| `nlx <pkg>` | Execute package (`npx`) |

### TypeScript Config

```json
{
  "compilerOptions": {
    "target": "ESNext",
    "module": "ESNext",
    "moduleResolution": "bundler",
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "resolveJsonModule": true,
    "isolatedModules": true,
    "noEmit": true
  }
}
```

### ESLint, Nuxt, UnoCSS

File shape for those tools is in the `stack` skill.

### Git Hooks

```json
{
  "simple-git-hooks": {
    "pre-commit": "pnpm i --frozen-lockfile --ignore-scripts --offline && npx lint-staged"
  },
  "lint-staged": { "*": "eslint --fix" },
  "scripts": {
    "prepare": "npx simple-git-hooks"
  }
}
```

### pnpm Catalogs

Use named catalogs in `pnpm-workspace.yaml` for version management:

| Catalog | Purpose |
|---------|---------|
| `prod` | Production dependencies |
| `inlined` | Bundler-inlined dependencies |
| `dev` | Dev tools (linter, bundler, testing) |
| `frontend` | Frontend libraries |

**Avoid the default catalog.** Catalog names can be adjusted per project needs.

**Additional tools:**
- Use `pnpm-workspace-utils` for catalog management
- Use `nip` for interactive package management

---

## References

| Topic | Description | Reference |
|-------|-------------|-----------|
| Project Setup | .gitignore, GitHub Actions, VS Code extensions | [setting-up](references/setting-up.md) |
| Release Workflow | Automated releases with changelogithub | [release-workflow](references/release-workflow.md) |
| pnpm Catalog | Strict pnpm catalog configuration and tools | [pnpm-catalog](references/pnpm-catalog.md) |
| App Development | Vue/Nuxt/UnoCSS conventions and patterns | [app-development](references/app-development.md) |
| Monorepo | pnpm workspaces, centralized alias, Turborepo | [monorepo](references/monorepo.md) |
| Library Development | tsdown bundling, pure ESM publishing | [library-development](references/library-development.md) |
