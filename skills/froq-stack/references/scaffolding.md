# Scaffolding

Start from a generator, then apply froQ deltas. No froQ template repo is
actively maintained, so the generator output is the base and `overrides.md`
is the diff.

## Which generator

| Repo form | Command |
| --- | --- |
| npm library | `vp create vite:library` |
| single app / site | `vp create vite:application`, or `vp create nuxt` for Nuxt |
| monorepo | `vp create vite:monorepo` |
| code generator package | `vp create vite:generator` (monorepo only) |

Other shorthands exist (`vite`, `vue`, `svelte`, `next-app`,
`react-router`, `@tanstack/start`). Use them only when the repo really is
that framework — a froQ site is Nuxt or Vite, not Next.

`vp create` also accepts `github:user/repo` for a remote template and
`@org` for an org picker. Reach for those when a specific template is
worth reusing; do not build a froQ template repo until there are three
repos that would share it.

Non-interactive runs need the flags spelled out:

```sh
vp create vite:library --directory my-lib \
  --no-interactive --no-git --no-agent --no-editor
```

`--agent` writes `AGENTS.md`/`CLAUDE.md`. froQ writes those by hand, so
pass `--no-agent`.

## What `vite:library` gives you

```
src/index.ts
tests/index.test.ts
vite.config.ts       staged / pack / lint / fmt blocks
pnpm-workspace.yaml  default catalog (must be re-categorised) + vite override
tsconfig.json
.vite-hooks/pre-commit   → vp staged
package.json
```

- `build` is `vp pack` (tsdown inside), `test` is `vp test`, `check` is
  `vp check`, `prepare` is `vp config`.
- `pack` block carries `dts.generator: 'tsgo'` and `exports: true`; there
  is no separate `tsdown.config.ts`.
- `lint.options` enables `typeAware` and `typeCheck`.
- The pre-commit hook is `vp staged`, not `lint-staged`.

## What `vite:monorepo` gives you

```
packages/utils/     library package
apps/website/       app package
vite.config.ts      staged / fmt / lint / run blocks
pnpm-workspace.yaml packages: apps/*, packages/*, tools/*
```

- Root scripts: `ready` = `vp check && vp run -r test && vp run -r build`,
  `dev` = `vp run <app>#dev`.
- `catalogMode: prefer`.
- Root `lint` adds `jsPlugins` with `vite-plus/oxlint-plugin` and the
  `vite-plus/prefer-vite-plus-imports` rule — keep it.

## Deltas to apply after scaffolding

1. **Named catalogs.** The generators emit a default `catalog:` block.
   froQ uses named catalogs only (`prod`, `dev`), so every generator entry
   has to move into a category. See `overrides.md` — this is the biggest
   divergence.
2. **Lint composition.** The generators emit `lint: { ... }` in vp's native
   object form. Switch to `oxlint-flat-config/vite-plus` if the repo needs
   composable presets. See `lint-format.md`.
3. **`.gitignore`.** Add what the generator omits — see
   `froq-create-repo/references/setting-up.md`.
4. **`AGENTS.md`.** Written by hand: how to embed `@froq/ui`, how to push
   and pull from that vendor copy.
5. **README.** Shape from `froq-create-repo/references/readme/`.
6. **No `paths` aliases.** Delete any `baseUrl`/`paths` the generator adds.
7. **`engines`.** `vite:monorepo` sets `node >= 22.18.0`; keep it — the
   oxlint TS config needs it.

## After the first commit

First npm publish stays manual so a Trusted Publisher can be attached. See
`froq-code-style/references/release-workflow.md`.
