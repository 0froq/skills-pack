---
name: simplify
description: Cut the current diff (PR branch or working tree) down to the smallest correct version by ablating each added piece and keeping only what proves needed. Use when asked to simplify, slim down, or clean up current changes.
license: MIT
metadata:
  author: froQ
  version: "0.2.0"
  source: Adapted from antfu/skills (antfu-simplify). https://github.com/0froq/skills-pack
---

# simplify

Shrink a diff to the fewest concepts a reader must hold. Method: ablation —
remove each piece the diff adds and see what concretely breaks. Keep only
what earns its place.

## When

Asked to simplify, slim down, clean up, or reduce the current changes or a
PR. Not for greenfield design, and not for refactoring code the diff did
not touch.

## Loop

1. **Read the diff.** Merge base against the PR target, or `git diff HEAD`
   for uncommitted work. Write the change's goal in one sentence — that
   sentence decides every case below.
2. **Inventory.** List each unit the diff introduces: function, parameter,
   option, branch, type, file, dependency, abstraction, comment, test.
3. **Ablate.** Try remove, inline, or merge. Decide by the table in the next
   section.
4. **Apply in batches.** After each batch run the repo's `check` script
   (`froq-stack` defines it as lint + format + typecheck + tests). Revert
   what breaks — that piece is now proven needed.
5. **Report.** One table of what was cut or kept and why, plus
   `git diff --stat` before and after. No commit unless asked.

## Cut or keep

| Piece | Default | Keep if |
| --- | --- | --- |
| New helper | Inline at the call site | 2+ callers, or the name carries a non-obvious step |
| Wrapper layer | Call the underlying thing | It hides real complexity or a changing boundary |
| Parameter / option | Hardcode the used value | A caller needs another value now |
| New type / generic | Use inference | Exported, or inference gives a worse type |
| Guard / try-catch | Delete and test | It covers a reachable case, not one the types already prevent |
| New file | Merge into its consumer | Multiple consumers or a distinct responsibility |
| Dependency | Few lines, or an existing dep | It handles edge cases you would otherwise get wrong |
| Comment | Delete | It explains why (constraint, workaround, surprise) |
| Test | Remove and see what goes unprotected | It covers behavior nothing else does |

Three things the table cannot say:

- **Speculation is cut.** Anything built for a need nobody has yet goes:
  unused options, hooks, plugin points, "just in case" generics.
- **Abstraction earns its size.** The third repetition gets extracted. The
  first and second do not. A good abstraction removes more code than it
  adds — that is the only test that matters.
- **Every cut is verified.** Run `check` after each batch; revert what
  breaks instead of reasoning about it.

## Smells

- Patches the symptom at the call site instead of the cause.
- A special case (`if (name === 'foo')`) where a general rule would cover it.
- Two near-identical paths; unify them.
- State or caches derivable from existing data.
- Hand-derived types where `typeof` / `ReturnType` / `Parameters` suffice.
- Tests asserting implementation details or mirroring the code line by line.

## Report

```md
| # | Piece | Action | Why |
| --- | --- | --- | --- |
| 1 | `parseOptions()` in src/cli.ts | inlined | one caller, 3 lines |
| 2 | `retry` option | removed | no caller passes it |
| 3 | `try/catch` in fetchData | kept | network errors reach users |

Diff: +142 -8 -> +61 -8. `check` passes.
```

Findings outside the diff (unrelated bugs, wider refactors) go in a
separate list and stay untouched.

## Boundaries

- Behavior stays the same: no features, no public API changes, no unrelated
  fixes.
- Scope is the diff, plus whatever must change to remove part of it.
  Surrounding code is out of bounds.
- No removal without a passing `check`.

## Hand-offs

- Style and naming the remaining code must match: `froq-code-style`
- Reviewing the change for correctness rather than size: no review skill
  exists yet, do it directly
