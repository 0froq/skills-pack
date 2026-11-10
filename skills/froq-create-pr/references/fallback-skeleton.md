# Fallback PR description skeleton

## When
1. Check the target repo for a PR template (`.github/PULL_REQUEST_TEMPLATE.md`, `PULL_REQUEST_TEMPLATE/`, `.yml` forms) and the org-level `.github` repo.
2. **If a template exists**: follow its fields and order strictly. Do not use this skill's skeleton.
3. **If none exists**: use the skeleton below every time for that repo. Do not invent a new structure per cloud agent run.

## Who owns overrides
- The bot responsible for that repo may keep a **repo-specific** fixed skeleton in its own profile memory (same *content types*; wording may differ).
- If a repo-specific skeleton exists, use that instead of the default below.
- Do not invent a one-off structure in a cloud agent prompt; point agents at this skill or the owning bot's stored skeleton.

## Required content (substance, not dogma)
1. **Related issue** when one exists — auto-close with `Fixes`/`Closes`/`Resolves #N`, or `Related to`/`Refs #N` if not closing; omit when there truly is none.
2. **What changed / why** under `### Description`.
3. **How verified** under `### Test` — commands, new tests, or why none.

Optional when useful: Context, breaking notes, reviewer focus, benchmarks, AI disclosure. Do not fluff, do not leave empty scaffolding, do not put Fixes in commit messages.

## Default skeleton (froQ, 2026-10-29)
First line is the issue keyword **with no Linked-issue heading** (Vite/core-minimal). Then open headings for Description and Test.

```markdown
Fixes #N

### Description

<!-- what + why -->

### Test

<!-- commands / new tests / why none -->
```

Use `Related to #N` or `Refs #N` on the first line instead of `Fixes #N` when the PR should not auto-close. Omit the first line when there is no issue.

Background helps? Insert `### Context` between the first line and `### Description`.

## Stability rule
Same repo → same content types and heading names on every PR. Only the body text under each heading changes with the work.
