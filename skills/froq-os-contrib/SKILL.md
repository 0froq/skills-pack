---
name: froq-os-contrib
description: froQ's open-source contribution operation (Vue ecosystem mainly, plus Zed and daily tools). Covers issue selection evaluation, upstream issue/PR tracking, two-phase fixing on forks, claim-comment drafts, and upstream permission boundaries. Use when fixing upstream issues, picking contribution targets, or drafting claim comments. Draft PRs via froq-create-pr, issues via froq-create-issue.
license: MIT
metadata:
  author: froQ
  version: "0.2.0"
  source: Migrated from Grok BOT fleet (Patt persona + rules). https://github.com/0froq/skills-pack
---

# froq-os-contrib

froQ's OSS contribution operation. Main lines: `x18n-dev/x18n`,
`voidzero-dev/void`; Vue ecosystem mainly, plus Zed and other daily tools.

## The only work

1. **Pick**: scan the GitHub Stars List `contrib` — the only selection
   source. If it is empty or missing, say so for that round; do not fall
   back to all stars. Theme lists (`vue-js-eco`, `parser`, `zed`,
   `unjs-eco`) are for classification only; `awesome` lists are not
   scanned; `my-stuff` is own repos. Exclude `0froq/*`, the Typst
   ecosystem, and repos with their own work lines (x18n, void, ghfs —
   those run their own sessions).
2. **Evaluate**: upstream contribution / into `0froq/ui` / own wheel /
   not worth it — conclusion first.
3. **Track**: follow up on issues and PRs already filed.
4. **Explore-and-fix**: friction found in daily tools or filed items —
   investigate, reproduce, fix. No mid-run reports; verify and report at
   the end.

## Session mode

- **One upstream, one session/topic; one issue, one thread.** Candidates,
   exploration, compares, claim/PR drafts all live in that item's own
   session. No cross-item context bleed.
- **Report where the work was taken.** Background tasks and subagents
   report back into the item's own session, not a different one.
- Unfiled candidates appear only in selection digests; joining `contrib`
   needs froQ's nod.
- Judgment discussions (new project / upstream / standalone app) only
   judge; once decided, open the item's own session.
- `zed-x18n` / `0froq/zed-x18n` are own projects, not the upstream line.

## Don't hijack PRs

When the issue author already says they will open a PR ("Happy to open a
PR" etc.), do not race them with an explore-and-fix. Discuss or assist at
most; leave the PR to them.

## Two-phase fixing on the fork

1. **Explore-and-fix.** Sync the fork before branching. Work with atomic
   commits; no forced squash to a single commit. Every commit's
   subject/body describes only that commit — **never** issue links,
   `Fixes #…`, `fix #…`, or a PR template pasted into a commit message,
   at any stage. Never open a draft PR on your own fork's `main`. When
   done (or when froQ says tidy up): self-review — if D fixes what C
   broke, squash C+D; if A/B/C/D are decoupled aspects of one big issue,
   do **not** squash them all. Wrap up with a clear, low-jargon Chinese
   summary of what changed (no commit history list) plus one compare link
   (base = merge-base against upstream / branch start, head = tip).
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

## Message headers and links

Fix reports, scratch reports before a PR, claim/PR drafts, and any
substantive item-session update: the issue or PR link goes first in the
message. All URLs — issues, PRs, compares — are written as Markdown
`[text](full-url)`, never bare links (`owner:repo:branch` compare links
get truncated by clients). Drafts for froQ's review go in fenced code
blocks.

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
- No mid-run reporting.
- No draft PRs fork→own-main.
- No upstream issue mentions or `Fixes` in any commit message.
- No forced single-commit squashes.
- No `?expand=1` description dumps.
- No free-form PR structure when no template exists — the fallback
  skeleton applies.
- No restating the issue description in claim comments.
- No reporting item results into unrelated sessions.

Tone: Chinese, short, dry. Quiet when there is nothing.

## Hand-offs

- PR body drafting: `froq-create-pr`
- Issue drafting: `froq-create-issue`
- External copy polish: `external-copy-polish`
- Contribution tracking: the yard / Work (see your global Notion rules)
