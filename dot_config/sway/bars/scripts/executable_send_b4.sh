#!/bin/sh
set -e

# wait to avoid problems
sleep 0.2

# my shortcut is win_left+p, so first release windows key if still pressed
DISPLAY=:0 /usr/bin/xdotool keyup Super_L > /dev/null

# enter password
DISPLAY=:0 /usr/bin/xdotool type b4rc0,BCD > /dev/null
DISPLAY=:0 /usr/bin/xdotool key Return > /dev/null
