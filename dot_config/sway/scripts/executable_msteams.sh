#!/bin/bash
set -euo pipefail


    # --ozone-platform=wayland \
chromium \
    --enable-features=VaapiVideoEncoder,VaapiVideoDecoder,UseOzonePlatform,WebRTCPipeWireCapturer \
    --app=https://teams.microsoft.com \
    --user-data-dir=.msteams \
    --class=msteams
