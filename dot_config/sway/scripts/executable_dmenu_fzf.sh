#!/bin/bash
set -euo pipefail

BASE_DIR="$(dirname "$(realpath "$0")")"
. "$BASE_DIR/_terminfo.sh"

dmenu_cmd="compgen -c | sort -u | fzf | xargs -r swaymsg -t command exec"

"$TERM" "$TERM_CLASS_FLAG" "Floating" "$TERM_EXEC_FLAG" bash -c "$dmenu_cmd"
