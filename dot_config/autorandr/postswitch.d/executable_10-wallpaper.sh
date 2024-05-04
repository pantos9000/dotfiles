#!/bin/bash
set -euo pipefail

WALLPAPERS_DIR="$HOME/.wallpapers"

feh \
    --no-fehbg \
    --bg-scale \
    "$WALLPAPERS_DIR/floating_island.jpg" \
    "$WALLPAPERS_DIR/space_block.jpg" \
    "$WALLPAPERS_DIR/planetside.jpg" \
    "$WALLPAPERS_DIR/observation_deck.jpg" \
    "$WALLPAPERS_DIR/space_surfer.jpg"
