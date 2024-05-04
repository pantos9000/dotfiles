#!/bin/bash
set -euo pipefail

LOCATION="/tmp"
FILENAME="screenshot-$(date +%F-%T).png"

# we don't want expression expansion here, so disable shellcheck warning
# shellcheck disable=SC2016
scrot \
    -s "$LOCATION/$FILENAME" \
    -e 'xclip -selection clipboard -t image/png < $f'
