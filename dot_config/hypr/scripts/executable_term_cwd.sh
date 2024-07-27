#!/usr/bin/bash
set -euo pipefail

pid=$(hyprctl activewindow | grep pid | cut -d ' ' -f2)
ppid=$(pgrep --newest --parent "$pid")
cwd="$(readlink "/proc/$ppid/cwd" || echo "$HOME")"

alacritty --working-directory "$cwd"
