# Stable facts (oss-contrib context)

Migrated from Grok BOT Patt profile memory (exported 2026-11-06). Current,
cross-session facts only. Live tracking lives in the Notion yard, not here.

## Selection source

- GitHub Stars List `contrib` = the only contribution-intent list and the
  only selection source. Joining `contrib` needs froQ's nod or him putting
  it there himself.
- Theme lists: `vue-js-eco`, `parser`, `zed`, `unjs-eco`
  (unplugin/UnJS) — classification only, never scanned.
- `awesome` = awesome-list only, not scanned. `my-stuff` = own repos.
- Excluded from selection: `0froq/*`, Typst ecosystem (typst, tinymist,
  etc. — froQ plans to unstar), neovim-related upstreams for now.
- icones: low interest, do not push new PR targets.
- shiki (shikijs ecosystem): preferred contribution direction — look at
  its issues first.
- Repos with their own work lines stay out of general selection:
  `x18n-dev/x18n`, `voidzero-dev/void`, `antfu/ghfs` (each runs its own
  session/topic).

## Tracking

- Notion "开源贡献" tracking DB under the yard / Work — filed issues and
  PRs (https://app.notion.com/p/dea9af49315e42078136634e11189f).
- Notion "贡献笔记" DB (built 2026-10-28) under Memory:
  collection://876f888a-4b24-41a5-a4f0-8d8d1b387101. Fields: project,
  maintainers (multi), repo, related PR.
- osdash data model: the contribution unit is the PR; an issue is optional
  context. One contribution maps to 0..n issues. Contribution types
  (multi): claimed fix, proposal, help/diagnosis, non-code. "Whose turn"
  is its own field.

## Per-repo conventions

- `0froq/void-fork`: fork for void upstream work (the name `0froq/void`
  is taken by another repo).
- `0froq/zed-x18n` + `zed-i18n-lens`: own extension projects. zed-i18n-lens
  branches off 0.13.0 with extract/inline/rename code actions; extract
  should infer the key prefix from common segments of existing keys in
  the file; rename has no official i18n LSP yet — likely self-built.
- Zed: froQ has signed the Zed CLA; his CLA failures came from commits
  authored as Cursor Agent (unsigned). Upstream PR commits must be
  `0froq <sayhola@froq.me>`.
- Maintainer habit: cpojer (void) squash-merges — PR body can lag the
  actual merged diff. For behavior changes, verify the squashed diff
  matches the description.

## Machines and environment

- Two Macs: **Mini** (main, always on) and **Air** (travel). Messaging
  and daily Zed live on Mini.
- `~/code/.sync/`: Mini writes a snapshot for each `~/code` repo daily
  (own commits + uncommitted diffs). Before taking work, read only the
  repo's line in `.sync/INDEX`.
- Upstream write permissions are irrelevant — the boundary is
  "never act upstream as froQ", regardless of what the local `gh` login
  could do.

## Archived: model routing and fleet topology

Grok-era routing (Mini PI → Magpie → Devin SWE-2 for simple fixes; Grok
Build for complex) and the old group-chat topology are historical. Routing
and fleet layout are configured elsewhere now; nothing here is normative.
