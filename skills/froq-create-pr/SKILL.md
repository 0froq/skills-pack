---
name: froq-create-pr
description: Draft a PR title and description for a GitHub repo, mainly upstream OSS contributions. Covers the template lookup order, the fallback skeleton, Fixes rules, and the draft-only boundary. Use when froQ is about to open a PR, asks for a PR description, or wants a compare link. Contribution workflow context lives in froq-os-contrib.
license: MIT
metadata:
  author: froQ
  version: "0.3.1"
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

## Evidence

A body that describes a change is a claim. Reviewers of agent-written code
have mostly the body to judge by, so show the change instead of asserting it.

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
- **"Before" is live.** Production, the base branch, or the last deploy. Never a
  reverted or stashed copy dressed up as before.
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
  twice. That is what makes the pair readable rather than plausible.
- **The repo already has browser tests**: use those. The project's own harness
  is the reproducible form.

Never add Playwright or any browser tool to the upstream repo's dependencies
just to capture evidence. Capture from a temporary directory, or use what the
repo ships. Either way, look at every capture before using it.

## Boundaries

- Never `gh pr create` upstream. froQ opens by hand.
- No tip-commit + `?expand=1` description dumps.
- No test counts, coverage percentages, or file counts presented as evidence.
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
