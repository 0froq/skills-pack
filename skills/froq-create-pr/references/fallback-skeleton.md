# Fallback PR description skeleton

## When

1. Look for a PR template in two layers.
   - In the repo: `.github/`, then the repo root, then `docs/`. Valid names are
     `PULL_REQUEST_TEMPLATE.md` and a `PULL_REQUEST_TEMPLATE/` directory.
   - If the repo has none: the owner's `.github` repository, meaning
     `<org>/.github` for an org-owned repo or `<user>/.github` for a user-owned
     one, with the same `.github` then root then `docs` order.
2. If a template exists, follow its fields and order strictly. Do not use the
   skeleton below.
3. If none exists, use the skeleton below every time for that repo. Do not
   invent a new structure per PR.

## Repo-level overrides

A repo may keep its own fixed skeleton. Put it in the repo, next to the code that
needs it (`docs/`, `contributing.md`, or an `AGENTS.md` section), and point at it
from the task. A repo skeleton keeps the same content types as the default and
may differ in wording.

Never invent a one-off structure inside a task prompt. Point the agent at this
file or at the repo's own skeleton.

## Required content

1. **Related issue** when one exists. One per line so GitHub renders each as an
   issue card. Auto-close with `Fixes #N`, `Closes #N`, or `Resolves #N`. Use
   `Related to #N` or `Refs #N` for issues the PR should not close. Omit the
   lines when there is truly no issue.
2. **What changed and why**, under `### Description`.
3. **What shows it works**, under `### Test`.

`### Test` carries evidence, not counts. Paste the real command output, the two
sides of a bug, or the measured numbers. "Loaded tests pass" is not content.
The full ladder and the honesty rules are in the skill body.

## Default skeleton

The first line is the issue keyword, with no Linked-issue heading. Then open
headings for Description and Test.

```markdown
Fixes #N

### Description

<!-- what + why -->

### Test

<!-- real output / both sides / measurements -->
```

Use `Related to #N` or `Refs #N` instead of `Fixes #N` when the PR should not
auto-close. Omit the first line when there is no issue.

Prefer not to add a standalone `### Context`. Fold background into
`### Description`. Add it only when the material is necessary and independent
enough to carry its own heading, between `### Description` and `### Test`.

## Additions by decision type

The skill body decides which of these a given PR needs. The default skeleton is
only the floor.

- **`### Options`** for a proposal. A table of what was considered, the cost of
  each, and which one this PR takes. Include doing nothing. The table is the
  question, so no separate "please give feedback" paragraph.
- **A `Not in this PR` line** when the diff is deliberately partial. Name what
  was left out and why, so a small diff does not read as unfinished.
- **A risks or migration note** when there are real failure modes, a migration,
  or an external effect.

## Not additions

- No reading guide. Do not add a "where to look" or "reviewer focus" block.
- No attribution and no review status, unless froQ asks for the claim. That
  claim lives at the top of the body and is described in the skill body.
- No filler, no empty scaffolding, no `Fixes` in a commit message.

## Stability

Same repo, same content types and heading names on every PR. Only the body text
under each heading changes with the work.
