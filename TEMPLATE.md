# SKILL.md template

Copy this skeleton for every new skill in this pack. Sections marked
*(fixed)* keep their exact heading; domain sections are free-form.

```markdown
---
name: <dir-name>
description: <what it does + when to use, one paragraph, matches body language>
license: MIT
metadata:
  author: froQ
  version: "0.1.0"
  source: Hand-written. https://github.com/0froq/skills-pack
---

# <name>

<one-paragraph positioning: what question this layer answers, what it does
not answer. Two to four lines.>

## When        (optional; only if description cannot carry the trigger cases)

## <domain sections>

<the actual rules, freely organized. Tables, lists, code samples all fine.>

## Boundaries  (fixed, required)

<hard no's: what this skill must never do, what stays out of scope.
Write "None" if genuinely nothing, do not delete the section.>

## Hand-offs   (fixed, required)

<which skills this delegates to or is invoked by. One line each.
Write "None" if standalone.>

## References  (optional; only when references/ exists)

<one line per file under references/, name + what it covers>
```

## Conventions

- `name` equals the directory name. `froq-` prefix marks froQ-personal
  workflow/env skills; generic methodology skills carry no prefix.
- `metadata.version` is semver: PATCH for content fixes, MINOR for new
  sections/references, MAJOR at `1.0.0` when stable.
- Body language follows L1: English is the target, Chinese is transitional.
  `description` always matches the body language.
- Supporting docs go in `references/`, executable scripts in `scripts/`.
  No generation scripts, no vendored upstream docs.
