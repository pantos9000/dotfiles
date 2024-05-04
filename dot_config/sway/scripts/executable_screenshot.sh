#!/bin/bash
set -euo pipefail

LOCATION="/tmp"
FILENAME="screenshot-$(date +%F-%T).png"

grim -g "$(slurp)" "$LOCATION/$FILENAME"
