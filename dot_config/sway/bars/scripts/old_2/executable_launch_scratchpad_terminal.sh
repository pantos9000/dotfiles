#!/bin/bash
set -e

lockfile="/tmp/.scratchlock"

cleanup() {
    rm -f "$lockfile"
}
trap exit INT TERM
trap cleanup EXIT

# lockfile from procmail package
lockfile -r 0 "$lockfile"

while true; do
  termite --class "Scratchpad"
done

