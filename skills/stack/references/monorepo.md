# Monorepo

Use a workspace when more than one package is published or when docs are a separate Nuxt app.

```
packages/*            libraries
docs/                 docs app, when it is its own package
playground/           manual host, when there is one
pnpm-workspace.yaml
```

Each package keeps its own `package.json` and the same `ci` scripts it would have alone.
The root script runs them with `pnpm -F` or `pnpm -r`. Do not invent a second task runner.

`voidzero-dev/vite-plus` adds `crates/`, `Cargo.toml`, and a `justfile` when the toolchain is Rust and JavaScript. Copy that only when this repo also ships Rust.
froQ sites such as [lig](https://github.com/0froq/lig) depend on `vite-plus` for `vp lint`, `vp fmt`, `vp test`, and `vp run` without copying the Rust workspace. A random library repo does not add `vp` by imitation.

`vueuse` uses `packages/`, `playgrounds/`, and Turborepo. Prefer pnpm filters. Add Turborepo only when the filters are already too slow to type, and say why in the root README.

Shared versions live in named catalogs. Internal packages depend on each other with `workspace:*`.
