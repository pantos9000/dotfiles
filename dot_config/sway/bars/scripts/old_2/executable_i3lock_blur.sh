#!/bin/bash
set -euo pipefail

# dependencies: imagemagick, i3lock, scrot, purple
# blur options: http://www.imagemagick.org/Usage/blur/#blur_args

IMAGE="/tmp/i3lock.png"

rm -rf "$IMAGE"
scrot "$IMAGE"
convert "$IMAGE" -scale 10% -scale 1000% "$IMAGE"
i3lock -n -f -i "$IMAGE"
