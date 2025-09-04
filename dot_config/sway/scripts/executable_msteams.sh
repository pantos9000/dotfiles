#!/bin/bash
set -euo pipefail

# --ozone-platform=wayland \
# --user-data-dir=.msteams \ # does not work with snap
chromium \
    --enable-features=VaapiVideoEncoder,VaapiVideoDecoder,UseOzonePlatform,WebRTCPipeWireCapturer \
    --app=https://teams.microsoft.com \
    --class=msteams
