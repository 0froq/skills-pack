# skills-pack design decisions

Settling the repo shape. Evidence sweep on 2026-11 done: 16 skills, naming
mixed, language mixed, working tree mid-rename, no .gitignore.

Layer letters: N naming, L language, R readme, G git housekeeping, F format.

## N1  prefix rule for skills in this pack
status: settled
evidence: 13 of 16 dirs use `froq-`; README claims all do; feeds-card-copy,
          lake-paper-academic-advisor, whittle do not. whittle was named
          deliberately (generic, not froQ-specific).
decision: `froq-` prefix marks froQ-personal workflow/env skills
          (workbench, code-style, os-contrib, notion-yard, briefing, design,
          create-*, stack, web-app, longform, mailman). Generic methodology
          skills carry no prefix (whittle, feeds-card-copy). Prefix is a
          namespacing claim, not a folder convention.

## N2  feeds-card-copy and lake-paper-academic-advisor naming
status: settled
edges:  blocks->N1
evidence: both predate the froq- convention; feeds-card-copy is feed-card
          copy, lake-paper-academic-advisor is academic advising. Neither is
          froQ-only, both are personal.
decision: feeds-card-copy stays unprefixed (generic copy recipe).
          lake-paper-academic-advisor stays unprefixed too, but is flagged:
          `lake-paper-` is a domain prefix not a personal marker. If more
          academic/paper skills arrive, they take `lake-` as their own
          namespace, not `froq-`.

## N3  `lake-` namespace for academic skills
status: settled
edges:  raised-by->N2
evidence: lake-paper-academic-advisor already carries `lake-`. The skill
          serves one specific ongoing project (Lake paper), not academic
          work in general.
decision: `lake-` is a project codename prefix, not an academic-domain
          namespace. If the Lake project spawns more skills they share
          `lake-`; a different project gets a different codename. No prefix
          claims a domain.

## L1  skill body language
status: settled
evidence: 15 of 16 SKILL.md bodies are Chinese; whittle is English. User said
          the direction is English but content is not yet settled, so other
          skills stay Chinese for now.
decision: English is the target for SKILL.md bodies and descriptions.
          Chinese is a transitional state, not the steady state. Each skill
          translates when its content is settled, not on a schedule.

## L2  when to translate
status: settled
edges:  blocks->L1
evidence: README and reference files are also Chinese. Translating before
          content settles doubles churn.
decision: translate a skill to English at the moment its content is
          settled. No batch, no deadline. The trigger is content settling,
          not calendar.

## R1  README skill table coverage
status: settled
evidence: table lists 13, misses feeds-card-copy, lake-paper-academic-advisor,
          whittle; mentions reserved froq-review that does not exist.
decision: add the three missing skills with one-line descriptions, keep
          froq-review as 预留. Do at the same edit as R2.

## R2  README claims vs reality
status: settled
edges:  blocks->N1, blocks->L1
evidence: "全部用 froq- 前缀" is false today; language claim unstated.
decision: rewrite README to state the actual rules: `froq-` prefix marks
          froQ-personal skills, generic methodology skills carry no prefix
          (N1); skill bodies are in transition from Chinese to English (L1).
          Add the frontmatter schema from F1. Drop nothing else.

## G1  working tree mid-rename
status: open
evidence: 44 uncommitted changes. Old-name skills deleted but not committed
          (cloudflare-sites, external-copy-polish, froq-voice-essay, oq,
          stack); new froq-* dirs all untracked; README modified not committed.
          User: hold off until most skills reach a first usable version.

## G2  skills.bak and .ghfs untracked
status: open
edges:  blocks->G1
evidence: skills.bak holds 10 superseded dirs; .ghfs is gh fs tool cache.

## G3  .gitignore
status: open
edges:  blocks->G2
evidence: no .gitignore exists. .ghfs is machine-local cache, likely should
          be ignored; skills.bak is user backup, likely should not be tracked
          but kept on disk.

## F1  frontmatter spec
status: settled
evidence: all 16 use name/description/metadata{author,version,source};
          version is date string "YYYY.MM.DD". description language follows
          body language. Spec is implicit, not written down.
decision: follow the agentskills.io spec exactly. Required: `name` (dir
          name, lowercase-hyphen), `description` (one line, matches body
          language). Optional `license: MIT` since the repo is MIT.
          `metadata.author`, `metadata.version`, `metadata.source` stay as
          metadata keys (spec puts version under metadata anyway).
          No other top-level keys beyond spec optionals.

## F2  when to bump version
status: settled
edges:  blocks->F1
evidence: feeds-card-copy and lake-paper-academic-advisor still on 2026.11.06,
          rest on 2026.11.09. No rule exists for what triggers a bump.
decision: `metadata.version` is semver `MAJOR.MINOR.PATCH`, not a date.
          Start every skill at `0.1.0`; bump PATCH for content fixes, MINOR
          for new reference/script sections, MAJOR at 1.0.0 when the skill
          is declared stable. Version is a maturity signal.
