#!/bin/bash
set -euo pipefail

# work around the fact that hypr can't overwrite workspace monitor settings
if ! hyprctl workspacerules | grep "unknown request" > /dev/null; then
    hyprctl reload # an old config is still in, remove with reload
    exit 0
fi

if hyprctl monitors | grep -q "Monitor DP-2"; then
    # left monitor is connected
    hyprctl --batch "\
        keyword workspace 1, monitor:DP-2, default:true; \
        keyword workspace 2, monitor:DP-2; \
        keyword workspace 3, monitor:DP-2; \
        keyword workspace 4, monitor:eDP-1, default:true; \
        dispatch moveworkspacetomonitor 1 DP-2; \
        dispatch moveworkspacetomonitor 2 DP-2; \
        dispatch moveworkspacetomonitor 3 DP-2; \
        " > /dev/null
    notify-send "left monitor connected"
else
    # left monitor is not connected
    hyprctl --batch "\
        keyword workspace 1, monitor:eDP-1,default:true;
        keyword workspace 2, monitor:eDP-1; \
        keyword workspace 3, monitor:eDP-1; \
        keyword workspace 4, monitor:eDP-1; \
        dispatch moveworkspacetomonitor 1 eDP-1; \
        dispatch moveworkspacetomonitor 2 eDP-1; \
        dispatch moveworkspacetomonitor 3 eDP-1; \
        " > /dev/null
fi

# middle (laptop) monitor is always connected
# (4 is actually part of it, but the default changes depending on the left monitor status)
hyprctl --batch "\
    keyword workspace 5, monitor:eDP-1; \
    keyword workspace 6, monitor:eDP-1; \
    " > /dev/null

if hyprctl monitors | grep -q "Monitor DP-1"; then
    # right monitor is connected
    hyprctl --batch "\
        keyword workspace 7, monitor:DP-1, default:true; \
        keyword workspace 8, monitor:DP-1; \
        keyword workspace 9, monitor:DP-1; \
        keyword workspace 10,monitor:DP-1; \
        dispatch moveworkspacetomonitor 7 DP-1; \
        dispatch moveworkspacetomonitor 8 DP-1; \
        dispatch moveworkspacetomonitor 9 DP-1; \
        dispatch moveworkspacetomonitor 10 DP-1; \
        " > /dev/null
    notify-send "right monitor connected"
else
    # right monitor is not connected
    hyprctl --batch "\
        keyword workspace 7, monitor:eDP-1; \
        keyword workspace 8, monitor:eDP-1; \
        keyword workspace 9, monitor:eDP-1; \
        keyword workspace 10, monitor:eDP-1; \
        dispatch moveworkspacetomonitor 7 eDP-1; \
        dispatch moveworkspacetomonitor 8 eDP-1; \
        dispatch moveworkspacetomonitor 9 eDP-1; \
        dispatch moveworkspacetomonitor 10 eDP-1; \
        " > /dev/null
fi
