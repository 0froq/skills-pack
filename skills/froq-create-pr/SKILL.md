---
name: froq-create-pr
description: Draft a PR title and description for a GitHub repo, mainly upstream OSS contributions. Covers the template lookup order, what the body must carry by change type, evidence, and the draft-only boundary. Use when froQ is about to open a PR, asks for a PR description, or wants a compare link.
license: MIT
metadata:
  author: froQ
  version: "0.4.0"
  source: Hand-written. https://github.com/0froq/skills-pack
---

# froq-create-pr

Draft PR titles and descriptions. froQ opens the PR from the web UI by hand.
The agent produces the draft and links, never `gh pr create`.

## Order: our shape first, template slots last

1. **Find the template.** Two layers, same order inside each.
   - In the repo: `.github/`, then the repo root, then `docs/`. Valid names
     are `PULL_REQUEST_TEMPLATE.md` and a `PULL_REQUEST_TEMPLATE/` directory.
   - If the repo has none: the owner's `.github` repository, meaning
     `<org>/.github` for an org-owned repo or `<user>/.github` for a
     user-owned one, with the same `.github` then root then `docs` order.

   A repo-level template wins over the shared one. A repo-level skeleton in a
   `contributing` doc or the task brief also counts.
2. **Lead with our shape.** The first section carries the summary content. When
   the template has an equivalent heading (`Description`, `Summary`, `What
   changed`), use its name for that section.
3. **Analysis sections next.** `Options` for a proposal, `Evidence`, `Not in
   this PR`, risks. These are ours. A template with no slot for them does not
   remove them.
4. **Template-only requirements last.** Checklists, type-of-change boxes,
   screenshot slots. Keep their heading names verbatim, fill them honestly,
   place them after our sections.

**Presence matters, order does not.** GitHub does not enforce template order,
and a bot can only check whether a heading or a `Fixes #N` line exists. Every
heading the template requires is present, named as the template names it, in
our order rather than its own.

One exception. When a repo demonstrably machine-checks the template, or its
CONTRIBUTING states a required order, fall back to the template's own order for
that repo and keep it consistent there.

When no template and no repo skeleton exist, use
[references/fallback-skeleton.md](references/fallback-skeleton.md): first line
`Fixes #N` / `Related to #N` (no Linked heading) → `### Description` →
`### Test`.

Same repo, same structure on every PR. No per-run improvisation.

## What the reviewer has to decide

The body is sized by the decision, not by the diff. A 400-line rename needs
five lines. A ten-line proposal may need a page.

| The reviewer must | Type | Body carries |
| --- | --- | --- |
| confirm it works and is safe | verify | Summary, Evidence |
| agree the design and scope are right | accept | Summary, plus risks and migration notes when they exist |
| weigh options | discuss | Summary, Options |

A PR can be two of these. A fix whose approach is contested is verify and
discuss. Present the part that blocks merge first.

Whatever the template calls its sections, the content follows this table. A
section headed `Test` carries evidence, never counts.

## Sections worth writing

**Summary.** The problem or the capability first, then what changed and why
this approach. One paragraph for a small change, two for a larger one. This is
the only section every PR needs.

**Evidence.** Required for verify, optional otherwise. The ladder and the
honesty rules are below. Name it whatever the template names it (`Test`,
`Testing`, `Verification`), and `### Evidence` when the template has no slot.
One heading, never two.

**Options.** Required for discuss. A table of what was considered, the cost of
each, and which one this PR takes. Include the option of doing nothing. The
table is also the question: the reviewer answers by picking a row. Do not add a
separate paragraph asking for feedback.

**Not in this PR.** Add when the diff is deliberately partial, which is common
in a proposal. Name what was left out and why it was left out, so a small diff
does not read as unfinished work.

**Boundaries and risks.** Add for accept when there are real failure modes, a
migration, or an external effect. One line per row, not an essay.

## Optional blocks, only when froQ asks

Both live at the top, above everything else. Neither is added by default.

**Claim.** When froQ asks for it, state who did the work. The second sentence
is not optional, because the first one alone reads as unreviewed output.

```text
> Most of this implementation was written by an agent. froQ has reviewed the code.
```

Add the third sentence only when it is true. If the agent picked the
architecture, do not claim the decisions were human. Ask when unsure.

```text
> Most of this implementation was written by an agent. froQ has reviewed the code, and the decisions in it are his.
```

```text
> Most of this implementation was written by an agent. froQ has reviewed the code. The approach was proposed by the agent and approved by froQ.
```

**User prompts.** Context for the reviewer about intent. Two kinds of line, and
the second is the useful one.

```text
> Asked for: fix #862 so `WITH`, `PRAGMA` and `EXPLAIN` print rows locally.
> Chose: ask better-sqlite3 for `reader` instead of matching the statement text.
```

No model name, no harness. `Chose` records decisions froQ made, which the diff
cannot show.

## Evidence

A body that describes a change is a claim. Reviewers of agent-written code have
mostly the body to judge by, so show the change instead of asserting it.

Use the strongest form available:

1. The same real end-to-end command, prompt, or interaction, before and after.
2. The same direct API, MCP, or protocol call, before and after.
3. The same discovery command, showing the changed capability.
4. One focused test with meaningful runtime output.
5. A minimal paste of real saved output.
6. Text only, with a concrete reason nothing could be run.

What keeps it honest:

- **A source diff is not evidence.** The reviewer can read the diff. `git show`,
  an allowlist, or a config object proves nothing about behavior.
- **One proof, one causal variable.** Never use a different failure as proof of
  this fix. When an unrelated base failure hides the behavior, isolate it first.
- **Two unrelated fixes get two proofs.** One capture cannot cover both.
- **"Before" is live.** Production, the base branch, or the last deploy. Never
  a reverted or stashed copy dressed up as before.
- **No test counts.** "240 tests pass, 5 added" is a self-assigned grade, and CI
  already shows it. Name the specific test and what it does: the case that fails
  before and passes after. Coverage percentages and file counts are the same
  trap.
- **Say what did not happen.** A check that failed, a number that got worse, a
  part nobody ran yet.
- **Never commit captures.** Screenshots and recordings go to froQ to attach, or
  into the PR body by hand. They do not belong in the branch.
- **Security fixes are the exception.** No working exploit in a public PR. Keep
  the reproduction private until the fix ships.

## Browser captures

Which tool depends on the job.

- **Needs froQ's logged-in state** to reach the page at all: `ego-browser`. It
  reuses his sessions, and nothing else can get in without credentials.
- **Needs comparable before and after**: a scripted browser (Playwright) run
  from a temporary directory. Same viewport, same crop, same starting state,
  twice.
- **The repo already has browser tests**: use those.

Never add Playwright or any browser tool to the upstream repo's dependencies
just to capture evidence. Either way, look at every capture before using it.

## Body rules

- `Fixes #N` / `Closes #N` goes only in the PR body, short `#N` form. One per
  line for several issues, so GitHub renders each as an issue card. Use
  `Related to #N` / `Refs #N` for issues the PR should not close.
- English, concise. Do not restate symptoms the issue already covers.
- No filler openers such as "This PR aims to". Start with the fact.
- Polish through `external-copy-polish` before handoff.
- Deliver as a fenced code block plus a compare link (base = merge-base, head =
  tip), with the PR or issue Markdown link at the top of the message.
- Author stays `0froq <sayhola@froq.me>`. No agent attribution beyond the opt-in
  claim above.

## Boundaries

- Never `gh pr create` upstream. froQ opens by hand.
- Never open a PR whose diff froQ has not read. Say so in the conversation
  instead of shipping an unread diff.
- Never delete a heading the template requires, and never check a box that was
  not verified.
- No tip-commit + `?expand=1` description dumps.
- No test counts, coverage percentages, or file counts presented as evidence.
- No upstream issue mentions in commits.
- **No reading-guide block.** A "where to look" section is easy to write as
  reassurance and hard to keep honest, and it can steer a reviewer away from the
  weakest part. Risk and decision points go in the sections above, in the place
  they belong.
- No attribution and no review-status line unless froQ asks for the claim.
- Workflow layer (pick work, claim, two-phase fixing, permission edges) is
  `froq-os-contrib`, not here.

## Hand-offs

- Contribution workflow: `froq-os-contrib`
- Issue this PR closes: drafted via `froq-create-issue`
- Explaining the change to froQ first: `froq-explain`
- External polish: `external-copy-polish`

## References

- [fallback-skeleton](references/fallback-skeleton.md): default PR body
  structure when no upstream template or repo skeleton exists.
