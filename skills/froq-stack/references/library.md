# Published library

Scaffold with `vp create vite:library` (see `scaffolding.md`), then apply
the froQ deltas. Layout:

```
src/index.ts          source
tests/index.test.ts   tests
vite.config.ts        staged / pack / lint / fmt blocks
tsconfig.json
pnpm-workspace.yaml   catalogs, even for one package
.github/workflows/ci.yml
AGENTS.md
```

There is no `tsdown.config.ts` — `vp pack` carries the build config in the
`pack` block of `vite.config.ts`:

```ts
pack: {
  dts: { generator: 'tsgo' },
  exports: true,
},
```

## package.json

- `"type": "module"`
- `exports` points at `dist`, plus `"./package.json"`
- `files: ["dist"]`
- `sideEffects: false` unless the package ships CSS
- `publishConfig.access: "public"` only when the package is really public
- scripts: `build` = `vp pack`, `dev` = `vp pack --watch`, `test` =
  `vp test`, `check` = `vp check`, `prepublishOnly` = `vp run build`,
  `prepare` = `vp config`
- add `knip` to `check` when the repo uses it

## Tests

`tests/` at the package root, or `foo.test.ts` next to `foo.ts` — pick per
repo and keep it. Snapshot outputs that are large or language-specific via
`toMatchFileSnapshot`.

## Catalogs

`pnpm-workspace.yaml` uses named catalogs and one of
`ignoreWorkspaceRootCheck: true` or `packages: ['.']` so a single-package
repo still gets catalog resolution. Names as in `overrides.md`
(`prod` / `dev`; add `inlined` / `frontend` only when a repo needs that
split), never the default `catalog:` that the generator emits.

## CI

`sxzz/workflows` `unit-test.yml`. Do not add a second lint job that
repeats `check`.

## Release

First npm publish is manual so a Trusted Publisher can be attached. Later
releases go through `vp run release` (bumpp) plus the release workflow —
see `froq-code-style/references/release-workflow.md`.

## Not this shape

- A package that ships source (`@froq/ui`): see `overrides.md`.
- A site: see `site.md`.
