#!/bin/bash

BASE_DIR="$(dirname "$(realpath "$0")")"

IMAGE=/tmp/i3lock.png
LOCK=$BASE_DIR/lock.png
RESOLUTION="$(xrandr | grep 'current' | sed -E 's/.*current\s([0-9]+)\sx\s([0-9]+).*/\1x\2/')"

scrot "$IMAGE"
ffmpeg \
    -f x11grab \
    -video_size "$RESOLUTION" \
    -y \
    -i "$DISPLAY" \
    -i "$LOCK" \
    -filter_complex "boxblur=16:1,overlay=(main_w-overlay_w)/2:(main_h-overlay_h)/2" \
    -vframes 1 \
    "$IMAGE" \
    -loglevel quiet
i3lock -n -f -i "$IMAGE"
rm "$IMAGE"
