# Fallback PR description skeleton

## When

1. Check the target repo for a PR template (`.github/PULL_REQUEST_TEMPLATE.md`,
   `PULL_REQUEST_TEMPLATE/`, or `.yml` forms) and the org-level `.github`
   repo.
2. If a template exists, follow its fields and order strictly. Do not use the
   skeleton below.
3. If none exists, use the skeleton below every time for that repo. Do not
   invent a new structure per PR.

## Repo-level overrides

A repo may keep its own fixed skeleton. Put it in the repo, next to the code
that needs it (`docs/`, `contributing.md`, or an `AGENTS.md` section), and
point at it from the task. A repo skeleton keeps the same content types as
the default and may differ in wording.

Never invent a one-off structure inside a task prompt. Point the agent at
this file or at the repo's own skeleton.

## Required content

1. **Related issue** when one exists. Auto-close with `Fixes`, `Closes`, or
   `Resolves #N`. Use `Related to` or `Refs #N` when the PR should not close
   it. Omit the line when there is truly no issue.
2. **What changed and why**, under `### Description`.
3. **How it was verified**, under `### Test`. Commands, new tests, or why
   none.

Optional when useful: Context, breaking notes, reviewer focus, benchmarks,
AI disclosure. Do not pad. Do not leave empty scaffolding. Do not put `Fixes`
in a commit message.

## Default skeleton

The first line is the issue keyword, with no Linked-issue heading. Then open
headings for Description and Test.

```markdown
Fixes #N

### Description

<!-- what + why -->

### Test

<!-- commands / new tests / why none -->
```

Use `Related to #N` or `Refs #N` instead of `Fixes #N` when the PR should not
auto-close. Omit the first line when there is no issue. Insert
`### Context` between the first line and `### Description` when background
helps.

## Stability

Same repo, same content types and heading names on every PR. Only the body
text under each heading changes with the work.
