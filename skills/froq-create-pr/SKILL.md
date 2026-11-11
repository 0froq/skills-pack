---
name: froq-create-pr
description: Draft PR titles and descriptions for GitHub repos, mainly upstream OSS contributions. Covers the template lookup order, the fallback skeleton, Fixes rules, and the draft-only boundary. Contribution workflow context lives in froq-os-contrib.
license: MIT
metadata:
  author: froQ
  version: "0.2.0"
  source: Hand-written. https://github.com/0froq/skills-pack
---

# froq-create-pr

Draft PR titles and descriptions. froQ opens the PR from the web UI by
hand. The agent produces the draft and links, never `gh pr create`.

## Structure order

1. **Upstream template first.** Check `.github/PULL_REQUEST_TEMPLATE*.md`
   and the org `.github` repo. If a template exists, fill its fields in
   order. Add or remove no headings.
2. **Repo-level skeleton.** If the contribution repo keeps its own fixed
   skeleton (registered in `froq-os-contrib`'s contribution log), it
   overrides the default.
3. **Fallback skeleton.** When neither exists, use
   [references/fallback-skeleton.md](references/fallback-skeleton.md):
   first line `Fixes #N` / `Related to #N` (no Linked heading) →
   `### Description` → `### Test`, optional `### Context` between.

Same repo, same structure on every PR. No per-run improvisation.

## Body rules

- `Fixes #N` / `Closes #N` goes **only in the PR body**, short `#N` form.
  Never a full issue URL, never in a commit message.
- English, concise: what/why first, how-tested after. Do not restate
  symptoms the issue already covers.
- Polish through `external-copy-polish` before handoff.
- Deliver as a fenced code block plus a compare link (base = merge-base,
  head = tip), with the PR/issue Markdown link at the top of the message.
- Author stays `0froq <sayhola@froq.me>`. No agent attribution.

## Boundaries

- Never `gh pr create` upstream. froQ opens by hand.
- No tip-commit + `?expand=1` description dumps.
- No upstream issue mentions in commits.
- Workflow layer (pick work, claim, two-phase fixing, permission edges)
  is `froq-os-contrib`, not here.

## Hand-offs

- Contribution workflow: `froq-os-contrib`
- Issue this PR closes: drafted via `froq-create-issue`
- External polish: `external-copy-polish`
- Fallback skeleton: [references/fallback-skeleton.md](references/fallback-skeleton.md)

## References

- [fallback-skeleton](references/fallback-skeleton.md): default PR body
  structure when no upstream template or repo skeleton exists.
