---
name: external-copy-polish
description: Polish external-facing copy that froQ will send himself, including email, issue and PR comments, PR descriptions, and short public replies, so it reads like a person wrote it. Governs how the text reads rather than what it says. Use before handing over any such draft.
license: MIT
metadata:
  author: froQ
  version: "0.2.0"
  source: Hand-written. https://github.com/0froq/skills-pack
---

# external-copy-polish

Rewrites a draft so it reads like froQ wrote it, not like a model. Only
touches voice and mechanics. Content, claims, commitments, and structure
come from elsewhere (`froq-create-pr` for PR bodies, `froq-create-issue`
for issues, `froq-os-contrib` for the contribution flow).

## When

froQ will **personally send** the text to someone outside: email, GitHub or
upstream issue/PR comments, PR descriptions, public short replies, form
messages.

A draft is not final copy, but it must still be sendable. If froQ has to
rewrite it himself, the polish failed.

## Punctuation

1. **Em dash / en dash.** Avoid unless truly necessary. Prefer a period,
   comma, or two sentences.
2. **Semicolon.** Rare. Acceptable for a lead-in plus several long parallel
   items (`First …; Second …; Third …`). Prefer periods or a list when that
   reads cleaner.
3. **Colon.** Restrained. After a colon, continue the same sentence
   (`I love three kinds of food: apple, banana, and watermelon.`). Do not
   colon-glue several independent sentences. Exception: attribution
   grammar expects (`X said: …`).

Chinese copy follows the same restraint on `——` and `；`. Split long
sentences instead.

## Register by occasion

| Occasion | Tone |
| --- | --- |
| Formal email, formal long reply | Full spelling, full grammar, polite |
| Upstream short reply, claim comment, casual PR chatter | Slightly casual is fine, with `:)` or `:D` used sparingly. Complete sentences stay the default |
| Never | Mechanical reuse of one line every time (e.g. always the identical `I'll open a PR shortly.`) |

- **Sentence-initial lowercase.** Not the default. Occasional use is fine
  for a standalone one-line paragraph that still reads. Normal paragraphs
  capitalize.
- **Dropped apostrophes** (`ill`, `dont`). Not the default. Rare use only.
  Otherwise keep `I'll` / `don't`.
- **Claim-style comments.** Name the chosen option or impl status, say a PR
  is coming, thank when it fits. Rewrite per issue. Do not paste froQ's
  spoken phrasing verbatim.
- **PR bodies.** Structure comes from the repo template, then a repo-owned
  skeleton, then `froq-create-pr`'s fallback. This skill only governs how
  the body reads.

## De-AI habits

### Stock lines: judged by scene, not banned

Real scenarios can use `happy to help`, a short thanks, or `I'll open a PR
shortly` when it is embedded in that comment's context.

Cut instead:

- Mechanical reuse of the same opener or closer on every draft.
- Empty stacks of `Hope this helps!` / `Looking forward to your
  feedback` with no content.
- Scripted hype unrelated to the thread (`Certainly!`, `Absolutely!`,
  `Great question!`).

Test: would a real person say this here? Keep. Does it read like a fill-in
template? Rewrite.

### Buzzword pile

Prefer plain words. Avoid unless the technical context truly needs them:
`leverage`, `utilize`, `robust`, `seamless`, `delve`, `landscape`,
`encompass`, `facilitate`, `streamline`, `comprehensive`, `cutting-edge`.

Avoid empty connectors: `Furthermore`, `Moreover`, `Additionally`,
`In conclusion`, `It's worth noting that`, `It's important to note that`.

### Over-neatness

- Do not force three symmetric paragraphs plus three parallel bullets into a
  short reply.
- Short comments: 1 to 3 natural sentences. Use sections only when the text
  is long.
- Do not restate an issue description the maintainer already wrote. Claim
  comments especially. Detail belongs in the PR.
- No triple-adjective stacks (`clean, elegant, and maintainable`).
- Avoid stuffing full asides into parentheses, dramatic ellipsis runs, and
  scare-quoting ordinary words.

### Sound human

- Lead with the action or conclusion, then only the detail needed.
- Concrete nouns (`proposal 1`, paths, behaviors) over vague correctness.
- External English should sound like an OSS contributor, not a support
  script or a model manual.
- Light imperfection is spice, not the recipe: one standalone lowercase
  line or one dropped apostrophe, not the whole draft.

### Self-reference

No `as an AI` or `generated with` in external drafts unless froQ asked for
disclosure or the repo requires an AI disclosure field.

## Scene cheat sheet

**A. Upstream claim / short comment.** Short, context-specific, full
spelling and capital starts as default. Occasional standalone lowercase or
dropped apostrophe is fine. May name the proposal, say a PR is ready, thank
when it fits. Never one frozen line.

**B. PR description.** Structure from templates. Clear what/why plus how
tested. Sparse connectors, sparse em dashes, colons only for same-sentence
continuations or required template fields. Formal complete spelling is the
default. `Fixes`/`Closes` only in the PR body, never in commits.

**C. Formal email.** Full spelling and grammar, clear structure. Polite
open and close are fine when they carry meaning, and empty stock stacks are
not. Keep dashes sparse and `;` and `:` careful. Sign-off and address form
match the relationship and the identity froQ uses there.

**D. Other external shorts.** Match the audience: familiar OSS reads like A,
professors or official or business reads like C.

## Checklist before handing over

1. Register right for the occasion?
2. Em dashes, semicolons, colons inside the rules?
3. Any mechanically repeated stock line?
4. Buzzword or empty-connector pile removed?
5. Reads like a person in that community, not a template?

## Boundaries

- **Never send.** Drafts go to froQ, who sends from the web UI, unless the
  calling skill already permits posting (froQ's own repos, agreed derived
  PRs).
- Does not decide content, claims, or commitments. Only how the copy reads.
- Not for internal notes, commit messages, TODOs, logs, group status
  reports, or agent-to-froQ chat.
- Not for in-group Chinese status updates, which are not external.

## Hand-offs

- Email drafts: `froq-mailman` produces them, this polishes before they
  land in Drafts.
- Issue and PR drafts: `froq-create-issue` / `froq-create-pr`.
- Contribution flow and upstream etiquette: `froq-os-contrib`.
- Chat-tone de-AI rewriting (not external text): `humanizer`.
- Longform essays in froQ's own voice: `froq-longform`.
