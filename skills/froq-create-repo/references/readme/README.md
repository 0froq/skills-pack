---
name: repo-face
description: >-
  Rewrite a froQ README, port README, or library README in the house style,
  including badges, acknowledgements, and the license section. Use when asked
  to rewrite a README, add star history, or state how a repo is licensed.
metadata:
  author: froQ
  version: "0.1.0"
  source: Hand-written from the LiG README pass. https://github.com/0froq/skills-pack
---

This file stores README shapes only.
Versions, colors, component names, and port lists stay in the owning repo.
Never copy facts from one repo into another repo's template.

## Layout

`SKILL.md` only routes.
One reference file per repo type, a skeleton with `{{SLOTS}}`.
A new repo type means a new reference file, not a new skill,
unless the process itself changes.
Toolchain conventions live in `froq-stack`, not repeated here.

Read exactly the one that matches:

| Repo | File |
| --- | --- |
| Public product, e.g. lig | [product.md](product.md) |
| Library, e.g. @froq/ui | [library.md](library.md) |
| Generated editor/tool port | [port.md](port.md) |
| Internal contract, e.g. core, syntax, compiler | [internal.md](internal.md) |

License rules in [license.md](license.md). Read it before writing any
README license section.

## Voice

English.
One sentence per line.
Break long sentences at commas.
Keep commands and tables precise.
License goes last.
Badges and Star History only on public product READMEs.
Never relicense third-party files as the repo's own.
