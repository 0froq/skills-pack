---
name: froq-design
description: froQ's design judgment layer for interfaces. Use when deciding how a UI should look, reviewing UI, or picking a visual direction. Component-library usage goes to that library's own skill (e.g. @froq/ui, @antfu/design); style config goes to froq-stack.
license: MIT
metadata:
  author: froQ
  version: "0.2.0"
  source: Hand-written. https://github.com/0froq/skills-pack
---

# froq-design

froQ's taste layer for interfaces. Answers "how should this screen look" and
"is this UI good". Produces decisions and review verdicts, not artifacts.
Does not answer "how to use a specific component library" (the library's own
skill) or "how to write style config" (`froq-stack`).

## Direction routing

Every interface starts from a brief. No brief → ask: who reads it, what type
(landing / tool / docs / dashboard / feed), whether a design system exists.

Then pick a direction:

| Interface type | Direction |
| --- | --- |
| froQ product surfaces (tools, docs, reading, briefing) | `@froq/ui` — the default product voice |
| Marketing landing, dense dashboards, styled experiments | Independent direction — define its own token contract; do not inherit `@froq/ui` aesthetics |
| Repo already on another system (@antfu/design, Tailwind UI, …) | That system's own rules; this skill still reviews |

`@froq/ui` is **a direction, not the truth**. It is the default for froQ
products because its taste matches; it is the wrong default for a landing
page or a Bloomberg-dense table. Routing wrong is worse than building slow.

## Invariants (any direction)

These hold regardless of which direction is picked. They are engineering
rules, not taste:

- **Own tokens, not colors.** Every surface, text, border resolves to a
  semantic token (`--*-bg`, `--*-fg`, `--*-muted`, `--*-line`, `--*-accent`).
  A raw `bg-white` or `text-gray-800` is a dark-mode bug. An independent
  direction must define its own token contract — never scatter raw colors.
- **Light/dark parity.** Every token has a dark variant baked in at
  definition time. Parity is not a follow-up pass.
- **Alpha vs opaque surfaces.** Nested surfaces (card in panel, input in
  card, active pill in a track) use translucent surface tokens so they
  composite over whatever is behind — a glass parent stays glass. Opaque
  surfaces are only for what must occlude: modals, portaled popovers,
  sticky headers.
- **Mono + tabular for technical values.** Numbers, sizes, durations,
  versions, hashes, paths → `font-mono tabular-nums`. Columns align, digits
  don't jitter.
- **Severity, not vibes.** Status uses a semantic severity ramp
  (fresh→stale, fast→slow, ok→error), never ad-hoc red/green chosen per
  case.
- **Contrast floor.** Custom ramps still pass text contrast (WCAG AA for
  body text). Parity means both modes pass, not just light.

## Anti-slop (voice)

- UI copy is short and declarative. Name the thing; do not pad labels
  ("Click here to view the…").
- No em-dash–laden prose in UI copy. Period or comma instead.
- One obvious affordance per context beats three competing buttons.

## Reviewing a screen — the three dials

Tune in this order; stop when the screen reads right.

1. **Density** — breathing room (`gap`, `p`, line-height). Dense is a
   choice, not a default; cramped is a bug.
2. **Hierarchy** — text levels (`fg` vs `muted` vs `faint`), weight, size.
   Most text is muted; reserve full-contrast for what matters and one
   accent for the single active element.
3. **Affordance** — one obvious action per context. If two buttons compete,
   one is wrong. Severity comes from the ramp, not a second color.

## Reuse before build

Before writing a component or a raw element, check the direction's library
first. For `@froq/ui` that means its component families (`display`,
`overlay`, `field`, `paper`, `devtools`, …); for an independent direction,
the project's own primitives. A new one-off element is justified only when
no existing primitive covers it.

## Redesign protocol

When restyling an existing screen onto a direction:

1. **Map colors to tokens first.** Replace every raw color with the
   semantic layer. Resist adding new colors.
2. **Swap elements family by family** (badges, then buttons, then inputs),
   checking the visual diff after each family.
3. **Check contrast in light and dark.** Both must pass.
4. **Tune the three dials.**

Target: near-zero visual diff from unifying, not a new look. Per-project
theme params (accent, fonts, base surface) are expected variation, not a
regression.

## Writing classes

Utilities go in `class` attributes, not attribute-style (`un-*`). Classes
are greppable, sortable by lint, and read consistently.

## Boundaries

- No hard-coded hex/raw colors in app UI (tokens only).
- No auto-picked directions: `@froq/ui` is not the default for non-product
  interfaces.
- No vendoring another design system's component catalog into this skill.
- Style-level config (UnoCSS presets, Tailwind) is `froq-stack`, not here.

## Hand-offs

- `@froq/ui` usage, tokens, and component families: `@froq/ui` repo docs
  (`vendor/ui/AGENTS.md` in consuming projects) — the product direction's
  concrete implementation.
- Vendor checklists for UI review: [references/web-checklist.md](references/web-checklist.md)
  (`web-design-guidelines`, `design-taste-frontend`).
- Style config (UnoCSS/Tailwind/oxfmt for styles): `froq-stack`.

## References

- [web-checklist](references/web-checklist.md): pointers to vendor UI
  review checklists (not vendored).
