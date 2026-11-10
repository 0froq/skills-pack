---
name: simplify
description: Cut the current diff (PR branch or working tree) down to the smallest correct version by ablating each added piece and keeping only what proves needed. Use when asked to simplify, slim down, or clean up current changes.
license: MIT
metadata:
  author: froQ
  version: "0.1.0"
  source: Adapted from antfu/skills (antfu-simplify). https://github.com/0froq/skills-pack
---

# simplify

Shrink a diff to the fewest concepts a reader must hold. Method: ablation —
for each piece the diff adds, try removing it and see what concretely breaks.
Keep only what earns its place.

## When

Asked to simplify, slim down, clean up, or reduce the current changes or PR.
Not for greenfield design, not for refactoring code the diff did not touch.

## Loop

1. **Read the diff.** Merge base against the PR target, or `git diff HEAD`
   for uncommitted work. Write the change's goal in one sentence — it is the
   yardstick for every decision below.
2. **Inventory.** List each unit the diff introduces: function, parameter,
   option, branch, type, file, dependency, abstraction, comment, test.
3. **Ablate each piece.** Try remove / inline / merge. Keep or cut by the
   table below.
4. **Apply in batches.** After each batch run the repo's checks (tests,
   typecheck, lint). Revert what breaks — that piece is proven needed.
5. **Report.** A short table of cut/kept + `git diff --stat` before and
   after. No commit unless asked.

## Keep vs cut

Cut when a piece is:

- Speculative — built for a need nobody has (extra options, hooks, generics).
- Redundant — repeats what the language, types, or an existing util does.
- Defensive against the impossible — guards on values the types guarantee.
- Indirection without payoff — one-use helpers, pass-through wrappers.
- Noise — narrating comments, unused exports, formatting churn, drive-by edits.

Keep when a piece is:

- Robustness — handles real edge cases (empty input, concurrency, cleanup).
- Universality — solves the general case, not just the reported one.
- Right-sized abstraction — the third repetition gets extracted; the first
  and second usually do not. A good abstraction removes more code than it
  adds.

Per-piece default:

| Piece | Default | Keep if |
|---|---|---|
| New helper | Inline at call site | 2+ callers, or the name carries a non-obvious step |
| Wrapper layer | Call the underlying thing | It hides real complexity or a changing boundary |
| Parameter / option | Hardcode the used value | A caller needs another value now |
| New type/generic | Use inference | Exported, or inference gives a worse type |
| Guard / try-catch | Delete and test | It covers a reachable case |
| New file | Merge into its consumer | Multiple consumers or distinct responsibility |
| Dependency | Few lines or existing dep | It handles edge cases you would get wrong |
| Comment | Delete | It explains why (constraint, workaround) |
| Test | Remove, see exposure | It covers behavior nothing else does |

## Smells

- Patches the symptom at the call site instead of the cause.
- Special-cased `if (name === 'foo')` where a general rule covers it.
- Two near-identical paths; unify them.
- State or caches derivable from existing data.
- Hand-derived types where `typeof`/`ReturnType`/`Parameters` suffice.
- Tests asserting implementation details or mirroring code line by line.

## Report format

```md
| # | Piece | Action | Why |
|---|-------|--------|-----|
| 1 | `parseOptions()` in src/cli.ts | inlined | one caller, 3 lines |
| 2 | `retry` option | removed | no caller passes it |
| 3 | `try/catch` in fetchData | kept | network errors reach users |

Diff: +142 -8 -> +61 -8. Tests, typecheck, lint pass.
```

Out-of-scope findings (unrelated bugs, wider refactors) are listed
separately and left alone.

## Boundaries

- Behavior stays the same. No features, no public API changes, no
  unrelated fixes.
- Scope is the diff. Never touch surrounding code the change did not
  introduce.
- Every removal is verified by the repo's checks, not assumed.

## Hand-offs

- Style and naming the diff must match: `froq-code-style`
- Full code review beyond diff-slimming: `froq-review` (reserved)
