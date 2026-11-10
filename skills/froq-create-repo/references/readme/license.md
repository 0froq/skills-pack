# License section

State the grant for this repo's own code.
Then list files that keep another license.
Do not fold those files into the repo grant.

Default for froQ's own code, when the maintainer has chosen it: MIT, `Copyright (c) {{YEAR}} froQ`, text in the repo `LICENSE`.

These stay as they are:

- SIL OFL 1.1 font data and font dependencies. Keep the copyright and `OFL.txt`. Do not sell the font alone. Do not relicense it as MIT.
- Unmodified upstream snapshots. Keep their license file and copyright lines.
- A derivative that still carries an upstream MIT notice. Add froQ's copyright line. Leave the upstream lines in place.
- An earlier release that was shipped under another license. New packages can change. Already published tags stay until they are published again.

If the repo has no root license, say that.
Do not invent one in the README.
