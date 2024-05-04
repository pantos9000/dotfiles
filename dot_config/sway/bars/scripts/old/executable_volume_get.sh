#!/bin/bash

volume=`amixer -M get Master | grep '\\[on\\]$' | sed -e s/"  Mono: Playback [0-9    ]* \["// | sed -e s/"\%.*"//`

echo -n $volume

