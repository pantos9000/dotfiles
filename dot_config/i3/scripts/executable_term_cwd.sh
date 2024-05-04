#!/usr/bin/bash
set -euo pipefail

BASE_DIR="$(dirname "$(realpath "$0")")"
. "$BASE_DIR/_terminfo.sh"

window=$(i3-msg -t get_tree | jq '.. | select(.type?) | select(.type=="con") | select(.focused==true).window')
pid="$(xprop -id "$window" _NET_WM_PID | cut -d' ' -f3)"
ppid=$(pgrep --newest --parent "$pid")
cwd="$(readlink "/proc/$ppid/cwd" || echo "$HOME")"

"$TERM" "$TERM_CWD_FLAG" "$cwd"
