# Rule history (oss-contrib)

Migrated from Grok BOT Patt `rules-and-workflows.md` (exported 2026-11-06,
non-exhaustive retrieval). Records deprecated/evolved rules and resolved
conflicts so old memory does not resurface. **Current rules: SKILL.md.**

## Deprecated / evolved

1. **Selection cadence**: early persona ran "Saturday 10:17"; from
   2026-10-16 every other day 10:17 (`17 10 */2 * *`), renamed
   「开源选题」. Scheduling now lives outside the skill; the cadence is
   not part of it.
2. **Selection source**: used to scan all stars; since 2026-10-29 only
   Stars List `contrib`. Star ≠ contribution intent — that is why it
   changed.
3. **"Issues I could help with"**: daily ~10:47 private report from
   2026-10-21; froQ removed it 2026-11-03. Help-type comments are not
   tracked.
4. **Claim strategy**: used to require a local implementation before
   claiming ("ready PR" comment); final form is the one-line default
   (`I'm working on it.`), detail in the fix PR, and drafts only — never
   post upstream directly.
5. **PR description**: used to dump with tip commit + `?expand=1`; since
   2026-10-28 a fenced English draft + compare, pasted by froQ in the web
   UI. Early no-template shape was Summary→Linked issue→Test; final is
   `Fixes/Related #N` → `### Description` → `### Test`
   (fallback-skeleton).
6. **Session routing evolution**: "open-source brainstorm" once carried
   concrete project follow-ups; later split into upstream-fix, x18n,
   void, ghfs lines. The semantic now is "one upstream per session".
7. **oss-contrib-watch**: ran denser; set to every 3h (8:23–23:23
   Asia/Shanghai) on 2026-10-23. Whether it is rebuilt is froQ's call.
8. **Cursor Project**: since 2026-11-04, exploration/fixes go into an
   existing Project (void-fork contrib / x18n contrib / ghfs), never a
   new one; replies carry the task only, no Project-preference restate.
   The session equivalent preserves the semantics.
9. **Local routing**: simple fixes could go Mini PI → Magpie → Devin
   SWE-2 (2026-11-02); complex on Grok Build 4.7 (no build-fast). Routing
   is configured elsewhere now.
10. **External polish**: descriptions once said deslop/unslop; finalized
    2026-11-04 as `external-copy-polish`.
11. **Don't hijack PRs**: codified 2026-10-30 (trigger: x18n#63 author
    offered to self-PR, we mistakenly opened #70).
12. **Typst / icones**: Typst ecosystem excluded entirely; icones gets no
    new-PR pushes (still eligible for help-type notes, which are off now).

## Conflicts resolved at migration

1. Description said weekly vs actual every-other-day → resolved by
   moving scheduling out of the skill.
2. ghfs had its own session and Cursor Project but was not in the
   description; selection exclusions did not list ghfs → SKILL.md lists
   ghfs as its own work line.
3. Watch routine text went to "upstream fix" while real routing was
   narrower (x18n/void/ghfs) → dissolved by the session model.
4. deslop/unslop vs external-copy-polish → unified to external-copy-polish.
5. Early "implement before claiming" vs current "one-line claim draft"
   → current wins.
6. shared_profile 2026-10-21 once said "match recent merged PRs when no
   template"; 2026-10-29 forbids free-form — the fallback skeleton is
   mandatory → new rule wins.

## Lessons

- **x18n#63→#70**: opening a PR when the author offered to self-PR is the
  direct origin of "don't hijack PRs".
- **PR body lag**: void's cpojer squash-merges; #711's merged result
  matched local tip byte-for-byte but the PR body never described the
  added narrow-skip + preserveRoutes. For behavior changes, verify the
  post-squash diff.
- **CLA**: Zed PRs failed CLA because commits were authored as Cursor
  Agent. Upstream commits must be `0froq <sayhola@froq.me>`.
