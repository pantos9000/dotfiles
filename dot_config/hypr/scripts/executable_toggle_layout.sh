#!/usr/bin/bash
set -euo pipefail

LAYOUT=$(hyprctl getoption general:layout | grep 'str' | cut -d ' ' -f2)

case "$LAYOUT" in
    "master")
        hyprctl keyword general:layout dwindle
        notify-send "Layout" "Dwindle"
        ;;
    "dwindle")
        hyprctl keyword general:layout master
        notify-send "Layout" "Master"
        ;;
    *)
        notify-send "Failed to read hypr layout!"
        ;;
esac
