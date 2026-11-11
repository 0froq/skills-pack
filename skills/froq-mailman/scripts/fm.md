# fm: Fastmail JMAP CLI

`fm` is implemented ([fm](fm), Python 3 stdlib, executable).

## Auth

Bearer token from keychain `fastmail-jmap` or env `FASTMAIL_JMAP_TOKEN`.
Fastmail's JMAP endpoint requires an **API token**, not an app password:
app passwords are IMAP/SMTP/CardDAV-only and the JMAP endpoint answers
401 `WWW-Authenticate: Bearer`. Create the token in Fastmail → Settings →
Privacy & Security → Connected apps & API tokens.

## Scope

Read, list, search, draft. No `send`, because the skill boundary is
draft-only.
