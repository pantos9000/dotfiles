#!/bin/bash
#set -euo pipefail

BASE_DIR="$(dirname "$(realpath "$0")")"

symbol_lockscreen="\u26BF"
symbol_suspend="\uF9B1"
symbol_hibernate="\uF7C9"
symbol_reboot="\u21BB"
symbol_shutdown="\u23FC"
option_lockscreen="Lock screen"
option_suspend="Suspend"
option_hibernate="Hibernate"
option_reboot="Reboot"
option_shutdown="Shut down"

options="$symbol_lockscreen\t$option_lockscreen"
options+="\n$symbol_suspend\t$option_suspend"
options+="\n$symbol_hibernate\t$option_hibernate"
options+="\n$symbol_reboot\t$option_reboot"
options+="\n$symbol_shutdown\t$option_shutdown"

chosen="$(echo -e "$options" | rofi \
    -lines 5 \
    -dmenu \
    -theme solarized_alternate \
    -font "JetBrains Mono NF 36" \
    -theme-str 'inputbar {enabled:false;}'\
    -theme-str 'window {height: 400;}'
)"

case "$chosen" in
    *"$option_lockscreen")
        sleep 1
        "$BASE_DIR/lock.sh"
        ;;
    *"$option_suspend")
        systemctl suspend
        ;;
    *"$option_hibernate")
        systemctl hibernate
        ;;
    *"$option_reboot")
        systemctl reboot
        ;;
    *"$option_shutdown")
        systemctl poweroff
        ;;
    *)
        echo "invalid option: '$chosen'"
        ;;
esac
