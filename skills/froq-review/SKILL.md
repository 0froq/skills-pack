---
name: froq-review
description: "Review someone else's pull request. Covers reading intent before code, judging implementation against the repo's own standards, verifying each finding before reporting it, and delivering a draft froQ can post himself. Use when froQ asks to review a PR, look over someone's changes, or judge whether a contribution should merge."
license: MIT
metadata:
  author: froQ
  version: "0.1.0"
  source: Hand-written from mattpocock/code-review, warpdotdev/review-pr, and addyosmani/code-review-and-quality methodology. https://github.com/0froq/skills-pack
---

# froq-review

Reviewing a PR someone else wrote. The product is a draft review froQ posts
himself. The value is fewer, verified findings, not more comments.

## Scope

Someone else's PR, on a repo froQ maintains or contributes to. Not your own
diff (`simplify` covers slimming your own change), and not the contribution
process around it (`froq-os-contrib`).

## Read order

1. **The description and the linked issue.** What did this claim to do? Without
   the intent nothing below can be judged. If there is no issue, take the
   description as the claim and say so in the review.
2. **The tests.** They state what the author believes the behavior is. Compare
   that belief with the claim above before reading the implementation.
3. **The implementation**, file by file, with the two axes below.
4. **CI and the verification story.** Green checks, or an explanation of what
   was run by hand and what was not.

## Two axes

Judge separately and report separately. A change can pass one and fail the
other, and merging the two lets one mask the other.

**Intent.** Does it do what was asked?
- Asked for and missing, or partial.
- Present but not asked for. That is scope creep, and it is a finding.
- Implemented, but the implementation looks wrong.

**Standards.** Does it follow this repo's own rules?
- Read `CONTRIBUTING.md`, `AGENTS.md`, `.editorconfig`, and any standards doc
  the repo documents before judging.
- Repo standards override your defaults. Where the repo endorses something you
  would flag, drop it.
- Skip anything the tooling enforces. If the linter or formatter would catch it,
  it is not a review finding.
- The smell baseline in [references/smells.md](references/smells.md) applies
  where the repo documents nothing. Each one is a labelled judgement call, never
  a hard violation.

## Before reporting a finding

This is the part that decides whether the review is worth reading.

- **Check the reachability.** Find the callers, guards, and tests that reach the
  changed line. If one of them rules the problem out, drop the finding.
- **Separate what the PR did from what was already there.** A pre-existing defect
  is a note, not this PR's fault.
- **Point at a line.** If you cannot name `path:line`, it does not go in the
  review. A vague concern becomes top-level context at most.
- **Zero findings is a valid answer.** Do not manufacture one so the review
  looks thorough.
- **No style the tooling owns**, no preference dressed as a defect, no
  "consider perhaps maybe".

If a test looks like it does not cover the change, prove it rather than assert
it: invert one condition the diff adds, run the suite in a throwaway worktree,
and restore the file. A mutation that stays green names the missing test case.

## Severity

Three levels. Anything that does not fit one of them probably is not a finding.

- **Blocking.** Bug, security issue, data loss, or behavior the PR claims that
  does not happen. Must be fixed before merge.
- **Follow-up.** Real problem that does not block this merge. Say it should be
  filed, and say where.
- **Nit.** Optional, and only with a concrete replacement. Without one, drop it.

Order by what matters: blocking first, then follow-up, then nits. One structural
problem and ten nits is a review about the structural problem.

## Dependency changes

A dependency added or bumped is a change like any other.

- Read the lockfile diff, not just `package.json`.
- One dependency per change. A bulk bump hides which package broke the build.
- Read the changelog for a major bump, and do not trust the patch level.
- If coverage around the dependency's behavior is thin, that gap is the finding.

## Output

Deliver a draft, in this shape:

1. A short summary: what the PR does, then the findings ordered by severity, then
   one line naming the single most important thing.
2. Per-line comments as `path:line` plus the text froQ would post there.
3. A proposed recommendation, marked as a proposal. The verdict is froQ's.

Write it as fenced blocks or a file froQ can copy from. Polish through
`external-copy-polish` only if froQ will post it verbatim.

No compliments, no "LGTM", no padding about what was done well unless froQ asked
for that separately. Quantify when you can: "this adds one query per item" beats
"this could be slow".

## Boundaries

- Never post, approve, request changes, or react. Drafts only.
- Never push to the author's branch. A fix goes to froQ as a diff or a patch.
- No review of code the diff does not touch, beyond a note in the summary.
- No findings you could not point at a line for.
- No invented severity: if nothing blocks merge, say nothing blocks merge.

## Hand-offs

- Slimming froQ's own diff: `simplify`
- Upstream contribution flow, claim comments, push gates: `froq-os-contrib`
- PR body drafting for froQ's own PRs: `froq-create-pr`
- Posting tone and mechanics: `external-copy-polish`

## References

- [smells](references/smells.md): the code-smell baseline used when a repo
  documents no standards of its own
