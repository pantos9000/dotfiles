#!/bin/bash

day=$(date | cut -d ' ' -f2)
day=${day%?}
cal | sed "s/\b\($day\)\b/<b><span color='lime'>\1<\/span><\/b>/g"

