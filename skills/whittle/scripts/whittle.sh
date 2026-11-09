#!/usr/bin/env bash
# whittle.sh — check and render a whittle decisions file.
# Usage:
#   whittle.sh check    <file>   run all invariants, exit 1 on any violation
#   whittle.sh frontier <file>   list solvable open nodes
#   whittle.sh tree     <file>   render open branches, collapse settled
#   whittle.sh tree --all <file> render everything
set -euo pipefail

cmd="${1:-check}"
case "$cmd" in
  check|frontier|tree) ;;
  *) echo "usage: whittle.sh {check|frontier|tree [--all]} <file>" >&2; exit 2 ;;
esac

all=0
if [ "$cmd" = tree ] && [ "${2:-}" = "--all" ]; then all=1; shift; fi
file="${2:-${1:-}}"
[ -f "$file" ] || { echo "no such file: $file" >&2; exit 2; }

# Parse items into a TSV stream:
# id \t status \t has_decision \t has_evidence \t edges(comma list type->target)
parse() {
  awk '
    /^## / {
      if (id != "") emit()
      line = $0; sub(/^## /, "", line)
      split(line, a, /  +/)
      id = a[1]; title = substr(line, length(a[1]) + 1)
      sub(/^ +/, "", title)
      status = "?"; dec = 0; ev = 0; edges = ""; n = 0
      next
    }
    id != "" && /^status:/   { status = $2; next }
    id != "" && /^edges:/    { sub(/^edges:[ ]*/, ""); edges = $0; gsub(/ /, "", edges); next }
    id != "" && /^evidence:/ { ev = 1; next }
    id != "" && /^decision:/ { dec = 1; next }
    END { if (id != "") emit() }
    function emit() {
      gsub(/\t/, " ", title)
      printf "%s\t%s\t%d\t%d\t%s\t%s\n", id, status, dec, ev, edges, title
    }
  ' "$file"
}

case "$cmd" in

check)
  parse | awk -F'\t' '
    {
      id = $1; st[id] = $2; dec[id] = $3; ev[id] = $4; title[id] = $6
      if (id in seen) { err("duplicate id: " id); next }
      seen[id] = 1; order[++n] = id
      m = split($5, e, ",")
      for (i = 1; i <= m; i++) {
        if (e[i] == "") continue
        split(e[i], t, "->")
        etype = t[1]; target = t[2]
        if (etype !~ /^(blocks|needs|narrows|supersedes|raised-by)$/) {
          err(id ": unknown edge type " etype); continue
        }
        if (etype == "supersedes") superseded[target] = 1
        ++edgecount
        # queue for END-phase checks once the full node set is known
        etarget[edgecount] = target; efrom[edgecount] = id; etype2[edgecount] = etype
      }
    }
    function err(msg) { printf "FAIL %s\n", msg; bad = 1 }
    END {
      # 1. targets exist; build ordering graph only on known targets
      for (i = 1; i <= edgecount; i++) {
        if (!(etarget[i] in seen)) {
          err(efrom[i] ": edge to unknown node " etarget[i] " (" etype2[i] ")")
          continue
        }
        if (etype2[i] == "blocks" || etype2[i] == "needs")
          if (!parents[efrom[i], etarget[i]]) {
            parents[efrom[i], etarget[i]] = 1; np[efrom[i]]++
          }
      }
      # 2. cycle check via Kahn on ordering edges
      for (i = 1; i <= n; i++) { id = order[i]; deg[id] = np[id] + 0 }
      changed = 1; solved = 0
      while (changed) {
        changed = 0
        for (i = 1; i <= n; i++) {
          id = order[i]
          if (!done[id] && deg[id] == 0) {
            done[id] = 1; solved++; changed = 1
            for (j = 1; j <= n; j++) {
              c = order[j]
              if (!done[c] && parents[c, id]) deg[c]--
            }
          }
        }
      }
      if (solved < n) {
        cyc = ""
        for (i = 1; i <= n; i++) if (!done[order[i]]) cyc = cyc " " order[i]
        err("ordering cycle among:" cyc)
      }
      # 3. settled under open ordering parent; 4. orphan/root evidence; 5. field rules
      for (i = 1; i <= n; i++) {
        id = order[i]
        has_parent = np[id] + 0
        # any edge at all?
        anyedge = 0
        for (j = 1; j <= edgecount; j++) if (efrom[j] == id) anyedge = 1
        if (!anyedge) {
          if (!ev[id]) err(id ": root without evidence:")
        }
        if (st[id] == "settled") {
          if (!dec[id]) err(id ": settled without decision:")
          for (j = 1; j <= n; j++) {
            p = order[j]
            if (parents[id, p] && st[p] == "open")
              err(id ": settled under open parent " p)
          }
        }
        if (st[id] == "dropped" && !(id in superseded))
          err(id ": dropped but nothing supersedes it")
        if (st[id] == "dropped" && dec[id])
          err(id ": dropped node carries decision:")
        if (st[id] != "open" && st[id] != "settled" && st[id] != "dropped")
          err(id ": bad status " st[id])
      }
      if (!bad) printf "OK  %d nodes, %d edges\n", n, edgecount
      exit bad ? 1 : 0
    }
  '
  ;;

frontier)
  parse | awk -F'\t' '
    {
      id = $1; st[id] = $2; title[id] = $6; order[++n] = id
      m = split($5, e, ",")
      for (i = 1; i <= m; i++) {
        split(e[i], t, "->")
        if (t[1] == "blocks" || t[1] == "needs") { np[id]++; par[id, t[2]] = 1 }
      }
    }
    END {
      for (i = 1; i <= n; i++) {
        id = order[i]
        if (st[id] != "open") continue
        settled_p = 0; blocker = ""
        for (j = 1; j <= n; j++) {
          p = order[j]
          if (par[id, p]) { if (st[p] == "settled" || st[p] == "dropped") settled_p++; else blocker = p }
        }
        if (settled_p == np[id])
          printf "%-4s %-48s SOLVABLE  %d of %d parents settled\n", id, title[id], settled_p, np[id]
        else
          printf "%-4s %-48s blocked by %s\n", id, title[id], blocker
      }
    }
  ' | sort -k3 -r
  ;;

tree)
  parse | awk -F'\t' -v all="$all" '
    {
      id = $1; st[id] = $2; title[id] = $6; order[++n] = id
      m = split($5, e, ",")
      disp = 0
      for (i = 1; i <= m; i++) {
        split(e[i], t, "->")
        # blocks/needs/narrows all determine display placement
        if (t[1] == "blocks" || t[1] == "needs" || t[1] == "narrows") {
          np[id]++
          ki = t[2]; kc[ki]++
          kids[ki SUBSEP kc[ki]] = id
          if (t[1] == "narrows") label[id] = "(narrowed)"
        }
        if (t[1] == "raised-by") disp = 1
      }
      # no display parent and no raised-by -> render as root
      if (!np[id] && !disp) isroot[id] = 1
      if (!np[id] && disp) isroot[id] = 1  # raised-by only: still top-level
    }
    function render(id, depth,   i, line, collapsed, c) {
      line = sprintf("%*s%-4s %-52s %s %s", depth*2, "", id, title[id], st[id], label[id])
      if (!all && st[id] != "open") {
        # settled/dropped node: collapse its settled descendants to a count,
        # still surface open ones
        collapsed = count_desc(id, "closed")
        if (collapsed > 0) line = line "  +" collapsed " settled"
        print line
        for (i = 1; i <= kc[id]; i++) {
          c = kids[id SUBSEP i]
          if (st[c] == "open" || has_open_desc(c)) render(c, depth + 1)
        }
        return
      }
      print line
      for (i = 1; i <= kc[id]; i++) render(kids[id SUBSEP i], depth + 1)
    }
    function count_desc(id, what,   i, s, c) {
      for (i = 1; i <= kc[id]; i++) {
        c = kids[id SUBSEP i]
        if (what == "closed" && st[c] == "open") continue
        s += 1 + count_desc(c, what)
      }
      return s + 0
    }
    function has_open_desc(id,   i, c) {
      if (st[id] == "open") return 1
      for (i = 1; i <= kc[id]; i++) {
        c = kids[id SUBSEP i]
        if (has_open_desc(c)) return 1
      }
      return 0
    }
    END {
      for (i = 1; i <= n; i++) {
        id = order[i]
        if (isroot[id]) render(id, 0)
      }
    }
  '
  ;;
esac
