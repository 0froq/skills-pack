---
name: whittle
description: Settle a pile of half-formed design questions to zero without losing the dependency order between them. Questions and answers form a growing DAG in one Markdown file. Use for design settling sessions, open-question lists, decision trees, ADR batches. Not for free-form brainstorming.
license: MIT
metadata:
  author: froQ
  version: "0.3.0"
  source: Hand-written. https://github.com/0froq/skills-pack
---

# whittle

Cut uncertainty away until one usable shape is left. A workflow, a file
format, and a checker. The file is the artifact; the tree is a by-product of
the work, never extra work.

Format spec and grammar: [references/format.md](references/format.md).
Checker and renderer: [scripts/whittle.sh](scripts/whittle.sh)
(`bash scripts/whittle.sh check <file>` / `frontier <file>` / `tree <file>`).

## File

One `decisions.md` (any name) in the repo under discussion. Plain Markdown.
Each item is a heading-level block:

```markdown
## A5  LayoutKind collapses to three values
status: settled
edges:  narrows->A1
evidence: `rg LayoutKind src` shows 5 variants, 2 unused since G9
decision: keep row, section, page; drop card, overlay

## B2  field shape
status: open
edges:  blocks->A5
```

- ID: one or two letters + number (`A5`, `G12`). Letters mark the layer.
- `status`: `open` / `settled` / `dropped`. `narrowed` is an edge label on the
  child, not a status.
- `edges`: comma-separated `<type>-><id>`, edges point child → parent.
- `evidence`: disk facts the item stands on. Required on roots, recommended
  everywhere.
- `decision`: the settled answer, one line. Required when status is `settled`.

## Edges

Five types. Ordering edges (`blocks`, `needs`) drive the frontier; outcome
edges (`narrows`, `supersedes`) record what a settle did; `raised-by` records
provenance.

| edge | meaning | ordering? |
| --- | --- | --- |
| `blocks` | parent must settle before this node can | yes |
| `needs` | parent's decision must hold for this node's reasoning | yes |
| `narrows` | this node stays settled, scope reduced by parent | no |
| `supersedes` | parent replaced this node, it is dropped | no |
| `raised-by` | settle of parent surfaced this node | no |

## Loop

The tree grows. A full question list up front is not required and not
expected. Direction alternates: evidence bottom-up, decisions top-down,
implementation last, in the same dependency order.

1. **Evidence sweep.** Measure the real state the questions live on (files,
   layouts, declarations, drift). Seed items only from measured facts. Skip
   anything theory-shaped.
2. **Grow or settle one item.** Either a measured fact becomes a new open
   node, or a frontier node gets settled. Both are writes with edges.
3. **Settle.** Pick a frontier node (all `blocks`/`needs` parents settled).
   Write `decision:`, flip status, write the outcome edge
   (`narrows`/`supersedes`/plain `blocks` resolution). Then spawn whatever the
   settle surfaced as new open nodes, each with `raised-by`.
4. **Optionally hand off a settled lane.** A fully settled subtree may be
   handed to implementation while other branches stay open. Handoff is a
   separate ledger (code, PRs, worker sessions); the decisions file does
   not track implementation progress. One writer per file remains.
5. **Check.** Run `whittle.sh check` after every settle. Never batch settles
   without a check between them: edges appended blind rot.
6. Repeat until open count is 0 and all lanes are done.

## Growth rules

- Every new node writes at least one edge on entry. Orphans are invalid.
- A node that attaches to nothing is a **new root**. It means the evidence
  sweep missed a layer. Stop, run a scoped sweep on that layer, write
  `evidence:`, then continue. Never settle a root on a guess.
- Two growth directions:
  - "B must be settled before A" → write `blocks->A` on B (B jumps ahead in
    the frontier).
  - "A settled the direction, detail remains" → child hangs under A via
    `blocks`/`narrows`, waits for the next layer.
- Watch the raise rate. If settles keep spawning opens at ≥1 for several
  rounds, stop answering and go back to evidence. The tree is splitting in
  place.

## Machine checks

`whittle.sh check` enforces, in order:

1. Every edge target exists. No duplicate IDs.
2. Ordering edges are acyclic.
3. A `settled` node never hangs under an `open` ordering parent.
4. Every non-root node has an edge; every root has `evidence:`.
5. Every `settled` node has `decision:`; every `dropped` node has a
   `supersedes` edge pointing at it.

Frontier = open nodes whose ordering parents are all settled. `whittle.sh
frontier` lists them with `N of M parents settled` so the next move is
readable at a glance.

## Visualization

Default render (`whittle.sh tree`) shows open branches expanded one level;
settled subtrees collapse to a count. `tree --all` expands everything for a
final review. A growing tree is never shown in full during the session.

```
A1  declaredBy replaces layer            settled (3 children collapsed)
├─ A2  repo rows stay visible            settled
├─ A5  LayoutKind to three values        settled (narrowed)
│  └─ B2  field shape                    open   2 of 3 parents settled
└─ E2  row glyph and section lock mark   open   blocked by A5
```

## Implementation feedback

Implementation runs outside the tree, but its findings flow back in as
new evidence nodes. History is never rewritten: when a finding
invalidates a settled node, do not reopen it. Append instead:

1. Worker writes a **finding node**: `open`, `blocks->A` on the challenged
   node, `evidence:` carrying the real failure (error output, measured
   conflict). Workers may write finding nodes but never `decision:` fields.
2. In a settling session, the finding is settled like any frontier node,
   then a superseding node (`supersedes->A`, `raised-by->F`) carries the
   corrected decision. A drops to `dropped`; its live children re-hang via
   `narrows`/`blocks` onto the replacement.
3. Check stays unchanged: the DAG only grows, status flips only go
   forward (open → settled/dropped), never backward.

## Hand-off outside the tree

Three things are deliberately not tree-shaped; keep them out of the file:

- **Implementation lanes.** A settled subtree may be handed off any time,
  and disjoint lanes may run in parallel. Workers get a forbidden-file
  list so they cannot reach into the next layer. Workers write finding
  nodes back into the file (see above) but never settle. A parent session
  rules on boundary conflicts the workers raise.
- **Review fan-out.** Parallel reviewers, one angle each, no edits. Report
  back, don't touch the tree.
- **The decision discussion itself.** The file holds outcomes and pointers,
  not the argument. Keep long reasoning in the chat or a linked doc.
