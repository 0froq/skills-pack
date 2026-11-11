---
name: froq-design
description: froQ's design judgment layer for interfaces. Use when deciding how a UI should look, reviewing UI, or picking a visual direction. Component-library usage goes to that library's own skill (e.g. @froq/ui, @antfu/design), and style config goes to froq-stack.
license: MIT
metadata:
  author: froQ
  version: "0.2.1"
  source: Hand-written. https://github.com/0froq/skills-pack
---

# froq-design

froQ's taste layer for interfaces. Answers "how should this screen look" and
"is this UI good". Produces decisions and review verdicts, not artifacts.
Does not answer "how to use a specific component library" (that library's
own skill) or "how to write style config" (`froq-stack`).

## Direction routing

Every interface starts from a brief. With no brief, ask three things: who
reads it, what kind of surface it is (landing, tool, docs, dashboard, feed),
and whether a design system already applies.

| Interface type | Direction |
| --- | --- |
| froQ product surfaces (tools, docs, reading, briefing) | `@froq/ui`, the default product voice |
| Marketing landing, dense dashboards, styled experiments | An independent direction with its own token contract. Do not inherit `@froq/ui` aesthetics |
| Repo already on another system (@antfu/design, Tailwind UI, …) | That system's own rules. This skill still reviews |

`@froq/ui` is a direction, not the truth. It is the default for froQ
products because its taste matches. It is the wrong default for a landing
page or a Bloomberg-dense table. Routing wrong is worse than building slow.

## Invariants

These hold whichever direction is picked. They are engineering rules rather
than taste.

**Own tokens, not colors.** Every surface, text, and border resolves to a
semantic token (`--*-bg`, `--*-fg`, `--*-muted`, `--*-line`, `--*-accent`).
A raw `bg-white` or `text-gray-800` is a dark-mode bug. An independent
direction defines its own token contract instead of scattering raw colors.

**Light/dark parity.** Every token carries a dark variant from the moment it
is defined. Parity is not a later pass.

**Alpha for nested surfaces.** A card in a panel, an input in a card, the
active pill in a track: all take translucent surface tokens so they
composite over what sits behind them and a glass parent stays glass. Opaque
surfaces are for what must occlude, such as modals, portaled popovers, and
sticky headers.

**Mono and tabular for technical values.** Numbers, sizes, durations,
versions, hashes, and paths take `font-mono tabular-nums`. Columns align and
digits stop jittering.

**Severity, not vibes.** Status uses a semantic severity ramp
(fresh→stale, fast→slow, ok→error). Never ad-hoc red or green chosen per
case.

**Contrast floor.** A custom ramp still passes text contrast, WCAG AA for
body text. Parity means both modes pass, not only light.

## Anti-slop (voice)

UI copy is short and declarative. Name the thing instead of padding the
label ("Click here to view the…"). Keep prose in UI copy free of dashes.
Use a period or a comma. One obvious affordance per context beats three
competing buttons.

## Reviewing a screen: the three dials

Tune in this order and stop when the screen reads right.

1. **Density.** Breathing room: `gap`, `p`, line-height. Dense is a choice,
   cramped is a bug.
2. **Hierarchy.** Text levels (`fg` vs `muted` vs `faint`), weight, size.
   Most text is muted. Reserve full contrast for what matters and one accent
   for the single active element.
3. **Affordance.** One obvious action per context. When two buttons compete,
   one of them is wrong. Severity comes from the ramp, not from a second
   color.

## Reuse before build

Before writing a component or a raw element, check the direction's library.
For `@froq/ui` that means its component families (`display`, `overlay`,
`field`, `paper`, `devtools`, and so on). For an independent direction it
means the project's own primitives. A new one-off element is justified only
when no existing primitive covers it.

## Redesign protocol

When restyling an existing screen onto a direction:

1. Map colors to tokens first. Replace every raw color with the semantic
   layer and resist adding new ones.
2. Swap elements family by family (badges, then buttons, then inputs),
   checking the visual diff after each family.
3. Check contrast in light and dark. Both must pass.
4. Tune the three dials.

The target is a near-zero visual diff from unifying, not a new look.
Per-project theme params (accent, fonts, base surface) are expected
variation, not regression.

## Writing classes

`class` is the default for utilities. Classes are greppable, sortable by
lint, and read consistently. Attributify is allowed where a project already
enables it, but only with the `un-` prefix and `prefixedOnly: true`, since a
bare attribute silently does nothing.

## Boundaries

- No hard-coded hex or raw colors in app UI. Tokens only.
- No auto-picked directions. `@froq/ui` is not the default for non-product
  interfaces.
- No vendoring another design system's component catalog into this skill.
- Style-level config (UnoCSS presets, Tailwind) belongs to `froq-stack`.

## Hand-offs

- `@froq/ui` usage, tokens, component families: the `@froq/ui` repo docs
  (`vendor/ui/AGENTS.md` in consuming projects), which is the product
  direction's concrete implementation
- Vendor checklists for UI review:
  [references/web-checklist.md](references/web-checklist.md)
  (`web-design-guidelines`, `design-taste-frontend`)
- Style config (UnoCSS, Tailwind, oxfmt for styles): `froq-stack`

## References

- [web-checklist](references/web-checklist.md): pointers to the vendor UI
  review checklists, not vendored here
