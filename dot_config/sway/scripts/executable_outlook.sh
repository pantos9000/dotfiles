#!/bin/bash
set -euo pipefail

# --ozone-platform=wayland \
# --user-data-dir=.outlook \
chromium \
    --enable-features=VaapiVideoEncoder,VaapiVideoDecoder,UseOzonePlatform,WebRTCPipeWireCapturer \
    --app=https://outlook.office365.com/mail/inbox \
    --class=outlook
