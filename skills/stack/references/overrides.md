# froQ overrides

These win over `starter-ts` and `vite-plus` in a froQ repo.

## Catalogs

Names already in use: `prod` and `dev`.
`oq` also allows `inlined` and `frontend`.
Do not rename them to `cli`, `testing`, `types`, or `agentic`.
Do not add a default catalog entry to a repo that does not already have one.
`lig` still has one default entry for `jiti`. Leave it until that repo is migrated on purpose.

`minimumReleaseAgeExcludePrune`, `trustPolicy: no-downgrade`, and `shellEmulator: true` are already set. Keep them.
Match `onlyBuiltDependencies` or `allowBuilds` to the major pnpm version already pinned in `packageManager`. Do not bump pnpm to copy a template.

## Hooks

pre-commit installs with `pnpm i --frozen-lockfile --ignore-scripts --offline`, then lint-staged runs fixes.
Sites (lig): lint-staged calls `vp lint` and `vp fmt` with `.oxlintrc.json` / `.oxfmtrc.json` (see [lint-format.md](lint-format.md)).
Published libraries: lint-staged runs `eslint --fix`.
Do not replace that with `pnpm run ci` or nano-staged.
`prepare` is `npx simple-git-hooks` unless the repo already syncs skills there.

## Packages that ship source

`@froq/ui` exports `src`, not `dist`. `files` is `["src"]`.
Root dependencies use normal version ranges. Consumers install `file:vendor/ui` and cannot see this repo's catalog.
Do not convert it to a tsdown library unless asked.

## Sites

Private. Nuxt. Cloudflare Workers through `cloudflare-sites`.
Tests sit next to source as `foo.test.ts` when a non-UI package has tests. UI is not given a test suite.

## Commits

Conventional Commits. Do not use `chore`.
One commit does one thing.
