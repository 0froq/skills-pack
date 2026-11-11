# whittle file format

One Markdown file. Anything outside `##` item blocks is free prose (context,
links, layer headers) and ignored by the checker.

## Grammar

```
item    := "## " id "  " title "\n" fields
id      := [A-Z]{1,2}[0-9]+
fields  := field*
field   := "status:   " status
         | "edges:    " edge (", " edge)*
         | "evidence: " text
         | "decision: " text
edge    := edgetype "->" id
status  := "open" | "settled" | "dropped"
edgetype:= "blocks" | "needs" | "narrows" | "supersedes" | "raised-by"
```

- Edges point **child → parent**. `B2 blocks->A5` reads "A5 blocks B2".
- Order of fields inside an item is fixed: `status`, `edges`, `evidence`,
  `decision`. Absent optional fields are just absent.
- Multiple edges on one line, comma-separated. One edge per type-target pair.
- `title` after the ID is free text, kept to one line.

## Field rules per status

| status | required | forbidden |
| --- | --- | --- |
| `open` | none beyond id+title | `decision:` |
| `settled` | `decision:` | none |
| `dropped` | incoming `supersedes` edge | `decision:` |

Roots (no `blocks`/`needs`/`raised-by` parent) must carry `evidence:`.

## Worked example

```markdown
# skilly decisions

Layer A is data model, B presentation, G operations.

## A1  declaredBy replaces layer
status: settled
evidence: rg shows `layer` read in 4 files, written in 0
decision: drop `layer`, derive from `declaredBy`

## A5  LayoutKind collapses to three values
status: settled
edges:  narrows->A1
evidence: 5 variants on disk, 2 unreachable since G9
decision: keep row, section, page

## B2  field shape
status: open
edges:  blocks->A5, raised-by->A1

## B3  card variant rendering
status: dropped
edges:  raised-by->A5
```

## What is not in the format

- No priority, owner, or date fields. Order comes from the DAG, not labels.
- No nested items. A sub-question is a new node with a `blocks` edge.
- No inline discussion under an item beyond the four fields. Long reasoning
  lives outside item blocks or in another doc.
