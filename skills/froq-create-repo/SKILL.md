---
name: froq-create-repo
description: Decision checklist and form routing for creating new froQ repositories. Use before creating any repo — gather license, README, form (package / web app / monorepo / docs / other), stack direction, then hand off to the matching spoke skill.
license: MIT
metadata:
  author: froQ
  version: "0.2.0"
  source: Hand-written. https://github.com/0froq/skills-pack
---

# froq-create-repo

Entry skill for creating a repo. Its only job is **asking everything and
routing** — directory structure and config live in `froq-stack` and the
per-form skills.

## Questions to ask first

Confirm before creating (ask, never guess):

1. **Form**: npm package/library, web app, monorepo, docs site, native
   app, script tool, or something else?
2. **License**: MIT by default for froQ repos, but confirm per repo.
   License wording: [references/readme/license.md](references/readme/license.md).
3. **README**: whether one is needed and who reads it. README shapes:
   [references/readme/](references/readme/README.md).
4. **Initial files**: `.gitignore`, GHA workflows, standard scripts,
   baseline tsconfig: [references/setting-up.md](references/setting-up.md).
5. **Stack**: after the form is fixed, ask the concrete stack (Nuxt for a
   web app? server needed?), plus public or private, CI and publishing.

## Routing

| Form | Go to |
| --- | --- |
| npm package / TS library | `froq-stack` `references/library.md` + `froq-code-style` |
| web app | `froq-web-app` (architecture + deploy) → `froq-stack` `references/site.md` |
| monorepo / Rust crate toolchain | `froq-stack` `references/monorepo.md` |
| docs site | `froq-stack` `references/site.md` (VitePress vs Nuxt, ask first) |

Shared tool config (lint/format, UnoCSS, catalogs, hooks) lives in
`froq-stack` — not duplicated in the form skills.

## Boundaries

- Never generate a directory before the form is confirmed.
- No concrete config here — point at `froq-stack`.

## Hand-offs

- Tool config files: `froq-stack`
- Web app architecture and Cloudflare deploy: `froq-web-app`
- In-repo code conventions: `froq-code-style`

## References

- [readme/](references/readme/README.md): README shapes per repo type
  (internal, library, port, product) plus license wording
- [setting-up](references/setting-up.md): one-time scaffolding files
