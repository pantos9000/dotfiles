#!/bin/bash
set -euo pipefail

left="$1"
right="$2"

swaymsg "output $left enable bg \$WP_1 fill"
swaymsg "output $right enable bg \$WP_0 fill"
swaymsg "workspace tmp"
swaymsg "workspace \$WS_1 output $left,   workspace \$WS_1,  move workspace to $left"
swaymsg "workspace \$WS_2 output $left,   workspace \$WS_2,  move workspace to $left"
swaymsg "workspace \$WS_3 output $left,   workspace \$WS_3,  move workspace to $left"
swaymsg "workspace \$WS_4 output $left,   workspace \$WS_4,  move workspace to $left"
swaymsg "workspace \$WS_5 output $right,  workspace \$WS_5,  move workspace to $right"
swaymsg "workspace \$WS_6 output $right,  workspace \$WS_6,  move workspace to $right"
swaymsg "workspace \$WS_7 output $right,  workspace \$WS_7,  move workspace to $right"
swaymsg "workspace \$WS_8 output $right,  workspace \$WS_8,  move workspace to $right"
swaymsg "workspace \$WS_9 output $right,  workspace \$WS_9,  move workspace to $right"
swaymsg "workspace \$WS_0 output $right,  workspace \$WS_0,  move workspace to $right"
swaymsg "workspace \$WS_F1 output $left,  workspace \$WS_F1, move workspace to $left"
swaymsg "workspace \$WS_F2 output $left,  workspace \$WS_F2, move workspace to $left"
swaymsg "workspace \$WS_F3 output $right, workspace \$WS_F3, move workspace to $right"
swaymsg "workspace \$WS_F4 output $right, workspace \$WS_F4, move workspace to $right"
swaymsg "workspace tmp, workspace \$WS_1, workspace \$WS_5"
