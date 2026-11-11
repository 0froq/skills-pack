---
name: froq-create-issue
description: Draft a title and body for a new GitHub issue, mainly upstream. Covers template lookup, minimal bug and feature structure, dedup, and delivery format. Use when froQ wants to file an issue, or asks for an issue title or body. Claim comments on existing issues belong to froq-os-contrib.
license: MIT
metadata:
  author: froQ
  version: "0.2.1"
  source: Hand-written. https://github.com/0froq/skills-pack
---

# froq-create-issue

Draft new issues. froQ submits by hand. The agent produces the draft only.

## Structure order

1. **Upstream template first.** Check `.github/ISSUE_TEMPLATE/`. If a
   template exists, fill its fields exactly. Pick the type (bug or feature)
   the template offers.
2. **No template.** Minimal structure:
   - Bug: `## Summary` (one-line symptom) → `## Reproduction` (minimal,
     runnable) → `## Expected` / `## Actual` → `## Environment`
     (versions, platform).
   - Feature: `## Summary` → `## Motivation` (what is impossible today)
     → `## Proposal` (one-line idea, details can follow).
3. **Dedup first.** Search open and closed upstream issues. If a match
   exists, do not open a new one. Add information under the existing issue
   instead.

## Body rules

- English, concise. No unrelated context and no solution pile-up. The issue
  states the problem. Design discussion belongs in comments or a PR.
- Reproduction over prose. A runnable minimal repro (command, code block,
  or a link to a branch on the user's fork) beats a long description.
- Polish through `external-copy-polish` before handing over.
- Deliver as a fenced code block for the body, with the title on its own
  line and the upstream new-issue link attached.
- No `Fixes`, no self-promotion, no AI attribution in the issue.

## Boundaries

- Never open issues upstream directly. froQ submits.
- Claim comments on existing issues (`I'm working on it.`) are not here.
  They live in `froq-os-contrib`.

## Hand-offs

- External polish: `external-copy-polish`
- Claim-comment flow and upstream etiquette: `froq-os-contrib`
- PR that closes the issue: `froq-create-pr`
