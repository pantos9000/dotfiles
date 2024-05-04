#!/bin/bash
set -euo pipefail

BASE_DIR="$(dirname "$(realpath "$0")")"
. "$BASE_DIR/_terminfo.sh"

dmenu_cmd="compgen -c | sort -u | fzf --border --color=dark | xargs -r i3-msg -t command exec"

"$TERM" "$TERM_CLASS_FLAG" "dmenu_fzf" "$TERM_EXEC_FLAG" bash -c "$dmenu_cmd"
