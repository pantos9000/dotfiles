#!/usr/bin/bash
set -euo pipefail

BASE_DIR="$(dirname "$(realpath "$0")")"
. "$BASE_DIR/_terminfo.sh"

pid=$(swaymsg -t get_tree | jq '.. | select(.type?) | select(.type=="con") | select(.focused==true).pid')
ppid=$(pgrep --newest --parent "$pid")
cwd="$(readlink "/proc/$ppid/cwd" || echo "$HOME")"

"$TERM" "$TERM_CWD_FLAG" "$cwd"
