# Published library

Follow `antfu/starter-ts` when the package is published to npm.

```
src/index.ts          source
test/                 tests and tsnapi snapshots
tsdown.config.ts      build
vitest.config.ts
eslint.config.js      @antfu/eslint-config, type: 'lib', pnpm: true
pnpm-workspace.yaml   catalogs, even for one package
.github/workflows/ci.yml
AGENTS.md
```

`package.json`:

- `"type": "module"`
- `exports` points at `dist`, plus `"./package.json"`
- `files` is `["dist"]`
- `sideEffects: false` unless the package has CSS
- scripts: `build` = tsdown, `dev` = tsdown --watch, `lint`, `typecheck`, `test`, `knip`, `ci` runs those in order, `prepack` builds, `release` = bumpp
- tsdown: `dts`, `exports`, `publint`

`pnpm-workspace.yaml` uses named catalogs and `catalogMode: prefer`.
starter-ts names them `cli`, `testing`, `types`, `inlined`, `agentic`.
A new froQ library uses the names in `overrides.md` instead.
One package still lists `packages: [.]` or `ignoreWorkspaceRootCheck: true` so catalogs work.

CI calls `sxzz/workflows` `unit-test.yml`. Do not copy a second lint job that repeats `ci`.

First npm publish is manual, so Trusted Publisher can be attached. Later releases go through `pnpm run release` and GitHub Actions.

Do not use this shape for a package that ships source, or for a site.
