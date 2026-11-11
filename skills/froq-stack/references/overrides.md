# froQ overrides

What a froQ repo does differently from the generators
(`vp create vite:*`, `antfu/starter-ts`, `voidzero-dev/vite-plus`).

## Catalogs

Measured across `ui`, `lig`, `osdash`: named catalogs are `dev` and `prod`.
Do not invent `cli`, `testing`, `types`, `agentic` from the starter
templates, and do not add `inlined`/`frontend` until a repo actually needs
that split.

**The default `catalog:` block is not used.** Every version lives in a
named category, so a reader can tell what a dependency is for from the
catalog name alone. `catalog:` with no name has no category and is banned.

Current violations, to fix when each repo is next touched:

| Repo | default entry | belongs in |
| --- | --- | --- |
| `ui` | `@froq/og-covers-layer` | `prod` (runtime layer for the docs site) |
| `lig`, `osdash` | `into-the-void` | `prod` |
| `lig`, `osdash` | `jiti` | `dev` |

When fixing one, move the entry into the named catalog and update the
`catalog:` references in `package.json`. Do not leave the same package in
both places.

`skilly` and `feeds` have no catalogs at all — fine for a repo with a
single package and no shared versions.

Keep `minimumReleaseAgeExcludePrune: true`, `trustPolicy: no-downgrade`,
and `shellEmulator: true` where already set. Match `onlyBuiltDependencies`
or `allowBuilds` to the pnpm major already pinned in `packageManager`; do
not bump pnpm to copy a template.

## Hooks

Two shapes in use:

- `simple-git-hooks` + `lint-staged`: `prepare` is
  `npx simple-git-hooks`, pre-commit does the offline frozen install and
  then `vp lint --fix` / `vp fmt` on staged files.
- `vp staged`: the `vite:library` template wires
  `.vite-hooks/pre-commit` → `vp staged` with
  `staged: { '*': 'vp check --fix' }` in `vite.config.ts`.

Pick one per repo and keep it. Do not run the full `ci` gate on every
commit, and do not use `nano-staged`.

## Packages that ship source

`@froq/ui` exports `src`, not `dist`. `files` is `["src"]`.

Root dependencies use normal version ranges because consumers install
`file:vendor/ui` and cannot see this repo's catalog. Do not convert it to
a bundled library unless asked.

## Lint and format

`vite.config.ts` holds both blocks (see `lint-format.md`). A repo still on
`.oxlintrc.json` + `.oxfmtrc.json` passes `--config` explicitly and can
migrate later; do not mix both styles in one repo.

## Sites

Private, Nuxt or Vite, deployed to Cloudflare through `froq-web-app`.
Tests sit next to source as `foo.test.ts` when a non-UI package has tests.
The UI library is not given a test suite.

## Commits

Conventional Commits. No `chore`. One commit does one thing.
