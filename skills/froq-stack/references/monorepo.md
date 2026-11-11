# Monorepo

Use a workspace when more than one package is published, or when a docs
site is a separate app next to the library.

## Shapes seen in froQ repos

```
ui/                 packages: ['.', 'docs']
                    root is the published package, docs is the site
skilly/             packages: ['.', 'site']
void-fork/          packages: [docs, packages/*, platform, playground/*]
```

Two layouts dominate:

- **root package + docs/site** — the root is the library, `docs/` (or
  `site/`) is a Nuxt app. `packages: ['.', 'docs']`. This is the common
  case for a froQ library that has a docs site.
- **`packages/*` + `apps/*`** — what `vp create vite:monorepo` generates.
  Use it when there are several libraries or several apps.

## Root config

`vite:monorepo` generates a root `vite.config.ts`:

```ts
staged: { '*': 'vp check --fix' },
fmt: {},
lint: {
  jsPlugins: [{ name: 'vite-plus', specifier: 'vite-plus/oxlint-plugin' }],
  rules: { 'vite-plus/prefer-vite-plus-imports': 'error' },
  options: { typeAware: true, typeCheck: true },
},
run: { cache: true },
```

`vp check` always reads the workspace root lint block, and Vite+ disables
nested lint configs. Per-package differences go in the root `lint` array
via `files` or `basePath`, not in a `lint` block inside each package.

## Scripts

Each package keeps its own `package.json` and the same `check` script it
would have alone. The root runs them with `vp run -r` or a filter:

```json
{
  "ready": "vp check && vp run -r test && vp run -r build",
  "dev": "vp run website#dev"
}
```

Do not invent a second task runner. Prefer pnpm filters and `vp run`.
Turborepo only when the filters are demonstrably too slow, and then say
why in the root README.

## Catalogs

`catalogMode: prefer` (strict in `void-fork`). Shared versions live in the
named catalogs from `overrides.md`. Internal packages depend on each other
with `workspace:*`; pnpm derives the build order, no manual sequencing.

## Rust toolchains

`voidzero-dev/vite-plus` adds `crates/`, `Cargo.toml`, and a `justfile`
because the toolchain is Rust and JavaScript. Copy that only when the repo
also ships Rust.
