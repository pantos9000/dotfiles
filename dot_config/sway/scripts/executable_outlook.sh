#!/bin/bash
set -euo pipefail

    # --ozone-platform=wayland \
chromium \
    --enable-features=VaapiVideoEncoder,VaapiVideoDecoder,UseOzonePlatform,WebRTCPipeWireCapturer \
    --app=https://outlook.office365.com/mail/inbox \
    --user-data-dir=.outlook \
    --class=outlook
