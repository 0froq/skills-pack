---
name: froq-os-contrib
description: How an agent executes one commissioned OSS contribution task. Pick an issue worth doing in a named repo, explore-and-fix on the fork, draft the claim comment, and deliver compare links and PR or issue drafts. Use when froQ asks to look at issues, fix an upstream issue, or draft a claim or PR.
license: MIT
metadata:
  author: froQ
  version: "0.3.1"
  source: Migrated from Grok BOT fleet (Patt persona + rules), rescoped to commissioned tasks. https://github.com/0froq/skills-pack
---

# froq-os-contrib

How an agent handles one commissioned OSS contribution. Covers what happens
inside a task: judging an issue, fixing on the fork, drafting claims and PR
bodies, delivering links. Does not cover lifecycle management such as
watching merged PRs, following up on reviews, or ping policy. Those belong
to froQ's sessions or an agent harness.

## Picking an issue

When froQ says "find issues worth doing in this repo", recent or older
leftovers, judge on these points.

- **Reproducibility helps but is not required.** A clear, reproducible bug
  is easier to work. A vague one is not automatically out.
- **Scope barely matters.** Small or large, what matters is whether the
  issue is real and fixable.
- **Maintainer activity does not decide.** Whether upstream answers fast
  has no bearing on whether the issue is worth doing.
- **Adjacent findings.** If a fix turns up a neighboring problem, fix it in
  the same PR only when the root cause is the same. Two issues sharing a
  file or feature but not a cause get separate PRs.

When froQ names candidate repos or lists, report on those. Do not widen the
search on your own.

## Don't hijack PRs

When the issue author already says they will open a PR ("Happy to open a
PR" and similar), do not race them with an explore-and-fix. Discuss or
assist at most. Leave the PR to them.

## Two-phase fixing on the fork

### 1. Explore-and-fix

Sync the fork before branching. Work with atomic commits. Do not force a
squash to a single commit.

Every commit's subject and body describe only that commit. Never put issue
links, `Fixes #…`, `fix #…`, or a pasted PR template in a commit message, at
any stage. Never open a draft PR on your own fork's `main`.

CI runs on the fork when you push. There is no separate "run upstream CI"
step in this skill.

When you are done, or when froQ says tidy up, self-review: if D fixes what
C broke, squash C and D. If A, B, C, D are decoupled aspects of one issue,
leave them separate. Then wrap up with a clear, low-jargon Chinese summary
of what changed, no commit history list, plus one compare link. Base is the
merge-base against upstream, or the branch start. Head is the tip.

### 2. Claim before the PR

After the exploration wraps and before the upstream PR, draft a short
English claim comment for froQ to review.

The default is one line. If the issue already states cause and symptom, do
not restate it. `I'm working on it.` or `I'll open a PR shortly.` is enough.
Add one line of approach preference and a short question for the maintainer
only when the path is debatable or the issue is vague. Detail belongs in the
fix PR description, not in the issue comment.

A claim comment is still required. Do not rely on the PR link alone. Deliver
drafts in fenced code blocks.

### 3. PR preparation

Body shape, template order, and the no-template fallback live in
`froq-create-pr`. This side holds only the process boundary.

- No tip-commit plus `?expand=1` description dumps. froQ pastes the
  description himself in the web UI.
- The same repo keeps the same structure across PRs.
- Deliver a fenced English PR body after `external-copy-polish`, the
  compare link, and atomic-commit notes when needed.
- `Fixes #N` belongs in the PR body only, as a short `#N`. A full issue URL
  and a commit message are both wrong places.
- Commit author is `0froq <sayhola@froq.me>` with no agent attribution.
  froQ opens the PR by hand.

## Upstream etiquette

- Mention a maintainer only when necessary.
- Review pushback is a discussion, not an order. Argue back on technical
  grounds instead of conforming silently.
- What happens after a PR is filed stays out of scope. froQ or the harness
  handles reviews, pings, and staleness.

## Message and link format

In fix reports, claim or PR drafts, and any substantive update, put the
issue or PR link first. Write it as Markdown `[text](full-url)`. Bare links
are wrong, and `owner:repo:branch` compare URLs get truncated by clients.
Drafts for froQ's review go in fenced code blocks.

## GitHub permission edges

Forbidden on external or upstream-target repos: filing PRs or issues,
commenting, reacting, touching labels. Nothing that makes any identity appear
in an upstream thread. Drafts and links only, and froQ acts in the web UI.

Allowed: froQ's own repos, froQ's own PRs, and derived PRs froQ would
plausibly approve, such as git tidying on his PR. Ask when unsure.

Code lives only in froQ's forks or private branches. A draft PR to a fork's
`main` is never right.

## Toolchain

- `mo` for repos, landing at `~/code/<owner>/<repo>`. npm CLIs via mise. No
  SSH. Name the machine (Mini or Air).
- Before taking work, read only the repo's line in `~/code/.sync/INDEX`.
  Read the full snapshot only when `changed=yes` or froQ says he edited
  locally.
- Tests are silent. No audio.
- External drafts go through `external-copy-polish` before delivery.
- No school resources (education email, institution network) for
  open-source or business work.

## Boundaries

- No hijacking author-declared PRs.
- No acting as froQ upstream or externally. Drafts and links only.
- No mid-run reporting on an explore-and-fix. Report at the end.
- No draft PRs from a fork to its own main.
- No upstream issue mentions or `Fixes` in any commit message.
- No forced single-commit squashes.
- No `?expand=1` description dumps.
- No free-form PR structure when no template exists. The fallback skeleton
  applies.
- No restating the issue description in claim comments.
- One PR solves one issue or implements one feature. Atomic, but not
  artificially small. Neighboring fixes belong together only when they share
  a root cause.
- No lifecycle management (review replies, pings, stale handling).

Tone: Chinese, short, dry. Quiet when there is nothing.

## Hand-offs

- PR body drafting: `froq-create-pr`
- Issue drafting: `froq-create-issue`
- External copy polish: `external-copy-polish`
- Contribution tracking: the yard / Work, governed by your global Notion
  rules
