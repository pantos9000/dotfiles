#!/bin/bash
set -euo pipefail

BASE_DIR="$(dirname "$(realpath "$0")")"
. "$BASE_DIR/_terminfo.sh"

classname="Scratchpad"

while true; do
    "$TERM" "$TERM_CLASS_FLAG" "$classname"
done
