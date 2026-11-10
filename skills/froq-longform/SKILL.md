---
name: froq-longform
description: Writing in froQ's own voice — long essays and 随笔 via references/voice-essay-workflow.md + STYLE.md. Use for froQ-authored longform only. External-facing copy polish goes through external-copy-polish; chat-tone de-AI rewriting goes through humanizer.
license: MIT
metadata:
  author: froQ
  version: "0.2.0"
  source: Hand-written. https://github.com/0froq/skills-pack
---

# froq-longform

Writes as froQ, for froQ. Covers the personal longform lane (essays, 随笔,
monthly pieces) — the one where the output must read like froQ wrote it
himself, in Chinese, in his current style phase.

| Task | Read |
| --- | --- |
| Longform essay / 随笔 in froQ's voice | [references/voice-essay-workflow.md](references/voice-essay-workflow.md) → required [references/STYLE.md](references/STYLE.md) |

`STYLE.md` stays in Chinese on purpose: it is a style specimen (「」 usage,
punctuation, voice phases, real example lines), not a rule doc. Translating
it would break the examples it exists to show.

The authoritative source for writing preference is the 「froQ 写作偏好」
page in the Notion writing area. This skill carries only the portable
rules; on conflict the Notion page wins.

## Boundaries

- Not for external-facing polish — drafts of email / issue / PR copy go
  through `external-copy-polish`.
- Not for chat-tone de-AI rewriting — that's `humanizer`.
- Not for academic writing — the `lake-warming-pathways` repo has its own
  project skill.
- Not for commit messages — the commit rules apply.
- Never publish. Drafts go to froQ for review.

## Hand-offs

- External copy polish: `external-copy-polish`
- Chat-tone de-AI: `humanizer`
- Material gathering: the yard via the Notion rules in your global prompt
  (contract path, notionctl, read discipline)

## References

- [voice-essay-workflow](references/voice-essay-workflow.md): the 8-step
  essay production loop
- [STYLE](references/STYLE.md): voice phases and current-style guide
  (Chinese, kept as a specimen)
