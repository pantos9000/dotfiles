#!/bin/bash
set -euo pipefail

if xrandr | grep HDMI-1 | grep disconnected; then
    # office
    export I3_OUT_0="eDP-1"
    export I3_OUT_1="DP-1-2"
    export I3_OUT_2="DP-1-1"
    export I3_OUT_HYBRID_1="DVI-I-2-2"
    export I3_OUT_HYBRID_2="DVI-I-1-1"
else
    # home
    export I3_OUT_0="eDP-1"
    export I3_OUT_1="HDMI-1"
    export I3_OUT_2="none"
    export I3_OUT_HYBRID_1="none"
    export I3_OUT_HYBRID_2="none"
fi
