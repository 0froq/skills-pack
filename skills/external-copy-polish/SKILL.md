---
name: external-copy-polish
description: >-
  Use when drafting any external-facing copy for the user to send themselves
  (email, issue/PR comments, PR descriptions, short public replies). Not for
  bot↔user chat.
license: MIT
metadata:
  author: froQ
  version: "0.1.0"
  source: Hand-written. https://github.com/0froq/skills-pack
---

# external-copy-polish

Makes drafts of external-facing copy read like the user wrote them. Governs
how the text reads, not what it says; structure still comes from repo
templates and `froq-create-pr`.

## When
Drafting text the user will **personally send** to outsiders: email, GitHub/upstream issue or PR comments, PR descriptions, public short replies, form messages.

## Not this skill
- bot ↔ user everyday chat
- in-group Chinese status / compare reports to the user
- commit messages (separate commit rules)
- internal notes, TODOs, logs

Drafts are not final copy, but they must still read like a person wrote them — not obvious AI — or the user has to rewrite them.

Hard boundary unchanged: bots do not post upstream/externally as the user unless that bot's persona already allows it (own repos / agreed derived PRs). Default: draft + link only; user sends from the web UI.

## Punctuation
1. **Em dash / en dash**: avoid unless truly necessary. Prefer period, comma, or two sentences.
2. **Semicolon**: rare. OK to consider for a lead-in plus several long parallel items (`First …; Second …; Third …`). Prefer periods or a list when that reads cleaner.
3. **Colon**: restrained. After a colon, continue **the same sentence** (e.g. `I love three kinds of food: apple, banana, and watermelon.`). Do not colon-glue several independent full sentences. Exception: attribution that grammar expects (`X said: …`).

## Register by occasion
| Occasion | Tone |
|----------|------|
| Formal email / formal long reply | Full spelling, full grammar, polite |
| Upstream short replies, claim comments, casual PR chatter | May be slightly casual / playful (`:)` / `:D` sparingly); complete writing is still the default |
| Avoid | Mechanical reuse of the same line every time (e.g. always the identical `I'll open a PR shortly.`) |

**Sentence-initial lowercase**: not the default. Occasional OK, especially for a standalone one-line paragraph that stays readable; normal paragraphs still capitalize.

**Dropping apostrophes** (`ill` / `dont`): not the default. Allowed occasionally; usual writing keeps `I'll` / `don't`.

Claim-style comments: briefly name the chosen option / impl status → say a PR is coming → thank when it fits. Rewrite per issue context. Do not paste the user's oral phrasing verbatim, and do not reuse one frozen sentence every time.

PR **structure** still follows the repo template, then any repo-owned skeleton, then `pr-fallback-skeleton`. This skill only governs how the body reads.

## De-AI habits

### Polite openers / stock lines: by scene, not a kill-list
Real scenarios can use `happy to help`, a short thanks, or `I'll open a PR shortly` **when embedded in that comment's context**.

Avoid:
- **Mechanical reuse** of the same opener/closer on every external draft
- **Empty stacks** of `Hope this helps!` / `Looking forward to your feedback` with no content
- **Scripted hype** unrelated to the thread (`Certainly!` / `Absolutely!` / `Great question!`)

Test: would a real person say this here? Keep. Does it feel like a fill-in template? Cut or rewrite.

### AI buzzword pile
Prefer plain words. Avoid unless the technical context truly needs them: `leverage`, `utilize`, `robust`, `seamless`, `delve`, `landscape`, `encompass`, `facilitate`, `streamline`, `comprehensive`, `cutting-edge`.

Avoid empty connectors: `Furthermore`, `Moreover`, `Additionally`, `In conclusion`, `It's worth noting that`, `It's important to note that`.

### Over-neatness
- Do not force three symmetric paragraphs plus three perfectly parallel bullets for a short reply
- Short comments: 1–3 natural sentences; section only when the text is long
- Do not restate an issue description the maintainer already wrote (claims especially; details go in the PR)
- Avoid triple-adjective stacks (`clean, elegant, and maintainable`)

### Sound human
- Lead with the action/conclusion, then only needed detail
- Concrete nouns (`proposal 1`, paths, behaviors) over vague correctness
- External English should sound like an OSS contributor, not a support script or model manual
- Informal spots may have light imperfect touches (standalone lowercase line, rare dropped apostrophe) as spice — not the whole draft

### Related punctuation habits
- Avoid stuffing full asides into parentheses
- Avoid dramatic ellipsis runs
- Avoid scare-quoting ordinary words
- Chinese external copy: same restraint on `——` and `；`; split long sentences when possible

### Emoji / emoticons
Casual short replies may use `:)` / `:D` rarely. Formal email: default none. Not every message.

### Self-reference
Do not put `as an AI` / `generated with` in external drafts unless the user asked for disclosure or the repo requires an AI disclosure field.

## Scene cheat sheet

### A. Upstream claim / short comment
Short; context-specific; full spelling and capital starts remain default. Occasional standalone lowercase or dropped apostrophe OK. May thank / name proposal / say PR is ready. Never the same frozen one-liner every time.

### B. PR description
Structure from templates as above. Clear what/why + how tested. Sparse empty connectors; sparse em dashes; colons only for same-sentence continuations or required template fields. Default formal complete spelling. `Fixes`/`Closes` only in the PR body (never in commits) — existing rule unchanged.

### C. Formal email
Full spelling and grammar; clear structure. Polite open/close OK when they fit and carry meaning — no empty stock stacks. Still sparse em dashes / misuse of `;` `:`. Sign-off and address forms follow whatever that bot already stores for the user.

### D. Other external shorts
Match the audience: familiar OSS → closer to A; professors / official / business → C.

## Checklist before handing the user a draft
1. Right register for the occasion?
2. Em dashes / semicolons / colons within the rules?
3. Any mechanical repeated stock line?
4. Buzzword / empty-connector pile removed?
5. Reads like a person in that community, not a template?

## Boundaries

- Never send. Drafts go to the user, who sends from the web UI, unless the
  calling skill already permits posting (own repos / agreed derived PRs).
- Does not decide content, claims, or commitments — only how the copy reads.
- Does not apply to internal notes, commit messages, or bot↔user chat.

## Hand-offs

- `froq-mailman`: email drafts polish through this skill before landing in
  the Drafts folder.
- `froq-os-contrib` / `froq-create-issue` / `froq-create-pr`: external
  comments and descriptions polish through this skill.
- `froq-longform`: longer essays may draw on the same voice rules.
