---
name: froq-mailman
description: froQ's Fastmail handling over JMAP: read, list, search, and draft emails. Drafts only by default, never sends. External copy goes through external-copy-polish before drafting.
license: MIT
metadata:
  author: froQ
  version: "0.1.0"
  source: Hand-written. https://github.com/0froq/skills-pack
---

# froq-mailman

Fastmail over JMAP via `scripts/fm` (Python 3 stdlib, no deps). Covers
reading, listing, searching, and drafting. Sending is not implemented on
purpose. See Boundaries.

## Auth

Fastmail **API token**, not an app password. The JMAP endpoint is
Bearer-only.
Create in Fastmail → Settings → Privacy & Security → Connected apps & API
tokens, with Mail read + write scope.

Stored in macOS keychain item `fastmail-jmap` (account = Fastmail address,
password = the `fmu1-...` token), or env `FASTMAIL_JMAP_TOKEN`. Scripts read
the keychain at runtime. The token never enters the repo or logs.

## Commands

```sh
fm mailboxes                    # list all mailboxes
fm list [mailbox] [--limit N]   # newest first
fm read <id>                    # full text body
fm search <text> [--limit N]
fm draft --to A[,B] --subject S [--body T | --body-file F | stdin] [--cc A]
```

Drafts land in the `Drafts` mailbox (`keywords.$draft`). There is no `send`
subcommand.

## Body rules

- English: full spelling and grammar, polite, no empty courtesy stacks.
  Chinese: relaxed but not greasy.
- Sign-off and salutation match the recipient relationship.
- External-facing drafts go through `external-copy-polish` before `fm draft`.
- Quote only the relevant section when replying. No full-thread quotes.

## Boundaries

- **Draft only, never send.** Output is a JMAP draft or a fenced body for
  froQ to paste. Actually sending requires froQ's explicit "send".
- No deleting mail, no mailbox/label structure changes, unless froQ asks.
- Token stays in the keychain, never in the repo, files, or command logs.

## Hand-offs

- External copy polish: `external-copy-polish`
- Voice for longer emails: `froq-longform` rules apply through the polish
- Upstream-issue style short replies: `froq-os-contrib`
