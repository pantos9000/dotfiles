#!/bin/bash

  COLOR=green
  SHADOW=0
  OFFSET=50
  INDENT=120
  #BARMODE=slider
  BARMODE=percentage
  DELAY=1

  VOLUME=`amixer -M get Master | grep '\\[on\\]$' | sed -e s/"  Mono: Playback [0-9]* \["// | sed -e s/"\%.*"//`
  killall osd_cat &> /dev/null
  osd_cat --offset=$OFFSET --indent=$INDENT --color=$COLOR --shadow=$SHADOW --barmode=$BARMODE --percentage=$VOLUME --delay=$DELAY

