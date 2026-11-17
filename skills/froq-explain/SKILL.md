---
name: froq-explain
description: "Explain anything to froQ: an issue, a PR, a bug, an error, an implementation, a design trade-off. Behaviour first, depth follows the question, no labelled scaffolding. Use when froQ asks what something means, why a symptom exists, or how something was fixed."
license: MIT
metadata:
  author: froQ
  version: "0.1.1"
  source: Hand-written from froQ's reading preferences, fitted on voidzero-dev/void#862 and #864. https://github.com/0froq/skills-pack
---

# froq-explain

How to make something land for froQ. Governs the shape and depth of an
explanation, not outward copy (`external-copy-polish`) and not PR or issue
bodies (`froq-create-pr` / `froq-create-issue`).

Output language follows froQ's. He writes Chinese, so the explanation is
Chinese with technical terms left in English.

## The unit is behaviour, not code position

Organise around what behaviour, under what condition, became what. Not around
files, functions, or a call chain. The reader is a user of the tool, not a
maintainer of that code.

File names, function names, and API names appear only when the question is
"where do I change it". Default to none.

## Three depths, chosen by the question

| The question | Where to land |
| --- | --- |
| Why does this symptom exist? What happened in this issue? | Behaviour only. Name what the decision was based on, not the API |
| How was it fixed? | Behaviour plus the mechanism name |
| Where do I change it? | File and function, naming the line that was replaced |

The same fact at all three depths:

1. The decision moved from "what does the SQL text look like" to "does the
   database say this statement returns rows".
2. The decision moved from matching the text prefix to better-sqlite3's
   `statement.reader`.
3. In `runExecute()` in `db.ts`, the `/^SELECT/` branch is replaced by
   `prepareSingleStatement()`.

## Two forms, used in parallel

**Behaviour narrative.** What the behaviour is now, why it is wrong, which step
in the middle decided it, what it became, what the behaviour is now. Carried by
sentences. No headings or bold labels reading "before", "after", "why this is
wrong".

**Regression narrative.** A behaviour that already shipped broken: how it
happened, what it cost, what changed, and the defect is gone. This is not
"describing the tests". It describes an existing error and its resolution.

When there is a regression, give both. The behaviour narrative says why the
current shape is right. The regression narrative says what used to be wrong.
With only one, the reader has to reconstruct the other.

## Why something is wrong: three grounds

Pick what the case actually is. They stack, and no template needs all three.

- **User expectation.** The command or feature exists to do X. It does not, so
  it is broken.
- **Consistency.** The same tool or API behaves one way on another path and
  differently here, so the user cannot tell which side to trust.
- **Internal contradiction.** What is reported and what happened disagree. It
  reports success and did nothing, or reports failure and changed data.

The ground comes from the problem. Picking the wrong one replaces the real
reason with a sentence that is true and empty.

## Forms that do not work for froQ

Measured. Do not use them.

- **One-liner.** Simplifying for its own sake. The detail is gone and the
  reader has to come back and ask.
- **Call-chain tour.** Walking from the entry point downward. Useful only to
  someone who already knows that codebase, and usually they do not.
- **Analogy.** A life-sized analogy cannot carry a mechanism, and it imports
  wrong understanding that was never there.
- **Code first.** Pasting the diff before explaining means the reader must
  understand the code first. The causality is backwards.
- **Maintainer view.** Only saying what future editors should watch out for.
  Answers a question nobody asked.

## Terms

Keep technical terms in English as written. Gloss a non-obvious one in a few
words the first time it appears, once. Do not smooth `RangeError` into "some
kind of error", because the reader then cannot match it to the code.

## When comparing versions, paste real output

For a behaviour change, take both sides from a real run. Do not retype and do
not tidy. Two outputs differing by one line carry more than a paragraph about
them.

## How you know it worked

The reader can restate two things unaided: what behaviour became what, and why
the previous one was wrong.

If they cannot, the explanation failed. That is not the reader's problem.

## Boundaries

- Not outward copy, PR bodies, issue bodies, or review comments. Each has its
  own skill.
- Never invent behaviour. Something not run is not "ran". Something not
  verified is not "verified".
- No fixed scaffolding in the explanation itself. Headings are allowed, but
  "before", "after", and "reason" are not fill-in slots.
- No listing for completeness. Detail that does not serve the conclusion stays
  out.

## Hand-offs

- Copy written for other people: `external-copy-polish`
- PR and issue bodies: `froq-create-pr` / `froq-create-issue`
- Reviewing someone else's code: `froq-review`
- Settling a design trade-off: `whittle`
