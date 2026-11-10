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
status: settled
edges:  raised-by->G1
evidence: skills.bak held 10 superseded dirs; .ghfs is gh fs tool cache.
          User: delete skills.bak, ignore .ghfs.
decision: skills.bak deleted from disk. .ghfs goes to .gitignore (G3).

## G3  .gitignore
status: settled
edges:  blocks->G2
evidence: no .gitignore existed. .ghfs is machine-local cache, skills.bak
          was user backup, both excluded.
decision: .gitignore contains `.ghfs/` and `skills.bak/` (belt-and-suspenders
          in case a backup ever reappears).

## T1  SKILL.md body template
status: settled
edges:  raised-by->R3
evidence: 16 skills surveyed; Boundaries/不做 appears in 8, Hand-offs/分工
          in 4, opening positioning paragraph inconsistent. R3 review needs
          a standard to confirm against.
decision: TEMPLATE.md at repo root + summary in README. Fixed skeleton:
          one-paragraph positioning, free domain sections, then required
          `## Boundaries` and `## Hand-offs` ("None" allowed, section may
          not be deleted). Optional `## When` and `## References`.

## N4  external-copy-polish placement
status: settled
edges:  raised-by->R3
evidence: file existed as tmp/external-copy-polish.md (103 lines, complete
          content from the old fleet pack). Referenced by mailman,
          os-contrib, create-issue/pr.
decision: added as unprefixed skill `external-copy-polish`. Generic writing
          methodology, same rule as whittle (N1). Template sections added:
          positioning paragraph, Boundaries, Hand-offs.

## N5  project-scoped skills do not belong in skills-pack
status: settled
edges:  narrows->N1, raised-by->R3
evidence: feeds-card-copy was a per-project skill whose source of truth is
          feeds repo's prompts/card-copy.md; automation runs in that repo,
          AGENTS.md references it 5x. pnpx installs all skills, no per-repo
          scoping exists.
decision: skills for one project's pipeline live in that repo, not in
          skills-pack. Same for bot-routine prompts: froq-briefing deleted
          (it runs inside the Grok Morning Chief routine, not in repo
          sessions). feeds-card-copy deleted from skills/ (it stays in
          feeds repo as prompts/card-copy.md, which is the SoT). Improved
          copy rules may be backported to a generic skill later if a real
          second consumer appears.

## R3  per-skill content review
status: open
edges:  blocks->G1
evidence: 15 skills' frontmatter was unified without content review; user
          has not manually approved any skill body yet. G1 cannot commit
          until each is confirmed.

Confirmed so far: froq-workbench (English, confirmed).
Removed from scope: feeds-card-copy, froq-briefing, froq-notion-yard
(N5: bot-routine / project-scoped prompts; notion-yard was redundant
with the global-prompt Notion contract). Remaining: 12 skills.

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
