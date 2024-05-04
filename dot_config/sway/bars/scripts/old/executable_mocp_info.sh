#!/bin/sh

  TITLE="`mocp -i | grep -a '^Title:' | sed -e 's/^.*: //'`";
  if [ "$TITLE" != "" ]; then
    ARTIST="`mocp -i | grep -a 'Artist:' | sed -e 's/^.*: //'`";
    SONGTITLE="`mocp -i | grep -a 'SongTitle:' | sed -e 's/^.*: //'`";
    ALBUM="`mocp -i | grep -a 'Album:' | sed -e 's/^.*: //'`";
    if [ "$ARTIST" != "" ]; then ARTIST="$ARTIST - "; fi
    if [ "$ALBUM" != "" ]; then ALBUM="($ALBUM)"; fi
    echo -n $ARTIST $SONGTITLE
  fi
