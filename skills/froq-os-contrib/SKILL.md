---
name: froq-os-contrib
description: How an agent executes one commissioned OSS contribution task — pick an issue worth doing in a named repo, explore-and-fix on the fork, draft the claim comment, and deliver compare links and PR/issue drafts. Use when froQ asks to look at issues, fix an upstream issue, or draft a claim/PR. PR body shape via froq-create-pr, issue body via froq-create-issue.
license: MIT
metadata:
  author: froQ
  version: "0.3.0"
  source: Migrated from Grok BOT fleet (Patt persona + rules), rescoped to commissioned tasks. https://github.com/0froq/skills-pack
---

# froq-os-contrib

How an agent handles one commissioned OSS contribution. The skill covers
what happens **inside** a task — judging an issue, fixing on the fork,
drafting claims and PR bodies, delivering links. It does not cover
lifecycle management (watching merged PRs, follow-up pings, monitoring
reviews): those belong to froQ's sessions or an agent harness, not here.

## Picking an issue

When froQ says "find issues worth doing in this repo" (recent or older
leftovers), judge on:

- **Reproducibility helps but is not required.** A clear, reproducible bug
  is easier to work; a vague one is not automatically out.
- **Scope does not matter much.** Small or large, what matters is whether
  it is real and fixable.
- **Maintainer activity is irrelevant to picking.** Whether upstream
  answers fast does not decide if the issue is worth doing.
- **Adjacent findings**: if a fix turns up a neighboring problem, fix it
  in the same PR only when the root cause is the same. Two issues that
  share a file or feature but have different causes get separate PRs.

When froQ names candidate repos or lists, do not widen the search —
report on what was asked.

## Don't hijack PRs

When the issue author already says they will open a PR ("Happy to open a
PR" etc.), do not race them with an explore-and-fix. Discuss or assist at
most; leave the PR to them.

## Two-phase fixing on the fork

1. **Explore-and-fix.** Sync the fork before branching. Work with atomic
   commits; no forced squash to a single commit. Every commit's
   subject/body describes only that commit — **never** issue links,
   `Fixes #…`, `fix #…`, or a PR template pasted into a commit message,
   at any stage. Never open a draft PR on your own fork's `main`. CI runs
   on the fork when you push — no separate "run upstream CI" step exists
   in this skill. When done (or when froQ says tidy up): self-review —
   if D fixes what C broke, squash C+D; if A/B/C/D are decoupled aspects
   of one big issue, do **not** squash them all. Wrap up with a clear,
   low-jargon Chinese summary of what changed (no commit history list)
   plus one compare link (base = merge-base against upstream / branch
   start, head = tip).
2. **Claim before PR (draft).** After the exploration wraps and before
   the upstream PR, draft a short English claim comment for froQ to
   review. **Default is one line**: if the issue already states cause and
   symptom, do not restate it — `I'm working on it.` / `I'll open a PR
   shortly.` is enough. Add one line of approach preference and a short
   question for the maintainer only when the path is debatable or the
   issue is vague. Detail belongs in the fix PR's description, not the
   issue comment. A claim comment is still required; do not rely on the
   PR link alone. Deliver drafts in fenced code blocks.
3. **PR preparation.** Body shape, template order, no-template fallback —
   `froq-create-pr`. This side only holds the process boundary: no
   tip-commit + `?expand=1` description dumps; froQ pastes the description
   himself in the web UI; same repo keeps the same structure across PRs.
   Deliver: fenced English PR body (after `external-copy-polish`), the
   compare link, and atomic-commit notes if needed. `Fixes #N` lives only
   in the PR body (short `#N`, never a full issue URL) — never in commits.
   Commit author stays `0froq <sayhola@froq.me>`, no agent attribution.
   froQ opens the PR by hand.

## Upstream etiquette

- Do not @-mention a maintainer unless necessary.
- Review pushback is a discussion, not an order — you may argue back on
  technical grounds rather than silently conforming.
- What happens after a PR is filed (review replies, pings, staleness) is
  out of scope: froQ or the harness handles it, not this skill.

## Message and link format

Fix reports, claim/PR drafts, and any substantive update: put the issue
or PR link first, written as Markdown `[text](full-url)` — never bare
links (`owner:repo:branch` compare URLs get truncated by clients).
Drafts for froQ's review go in fenced code blocks.

## GitHub permission edges (hard)

- **Forbidden**: on external or upstream-target repos, do not file PRs,
  file issues, comment, react, or touch labels — nothing that makes any
  identity appear in an upstream thread. Drafts and links only; froQ acts
  in the web UI.
- **Allowed**: froQ's own repos, froQ's own PRs, and derived PRs froQ
  would plausibly approve (e.g., git tidying on his PR). When unsure,
  ask.
- Code lives only in froQ's forks/private branches; never a draft PR to
  a fork's `main`.

## Toolchain

- `mo` for repos (`~/code/<owner>/<repo>`); npm CLIs via mise; no SSH;
  name the machine (Mini / Air).
- Before taking work, read only the repo's line in `~/code/.sync/INDEX`;
  read the full snapshot only when `changed=yes` or froQ says he edited
  locally.
- No audio in tests — silent tests.
- External drafts go through `external-copy-polish` before delivery.
- No school resources (education email, institution network) for
  open-source or business work.

## Boundaries

- No hijacking author-declared PRs.
- No acting as froQ upstream or externally — drafts and links only.
- No mid-run reporting on an explore-and-fix; report at the end.
- No draft PRs fork→own-main.
- No upstream issue mentions or `Fixes` in any commit message.
- No forced single-commit squashes.
- No `?expand=1` description dumps.
- No free-form PR structure when no template exists — the fallback
  skeleton applies.
- No restating the issue description in claim comments.
- One PR solves one issue or implements one feature. Atomic, but not
  artificially small — neighboring fixes belong together only when the
  root cause is shared.
- No lifecycle management (review replies, pings, stale handling) —
  outside this skill.

Tone: Chinese, short, dry. Quiet when there is nothing.

## Hand-offs

- PR body drafting: `froq-create-pr`
- Issue drafting: `froq-create-issue`
- External copy polish: `external-copy-polish`
- Contribution tracking: the yard / Work (see your global Notion rules)
