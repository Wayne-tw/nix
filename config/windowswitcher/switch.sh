#!/usr/bin/env bash
# requires: yabai, jq, choose-gui

windows=$(yabai -m query --windows)
idx=$(echo "$windows" | jq -r '.[] | "\(.app): \(.title)"' | /opt/homebrew/bin/choose -u -b fabd2f -c 427b58 -s 14 -n 15 -i "$@" <&0)

if [[ $idx -ge 0 ]]; then
    echo "$windows" | jq ".[$idx].id" | xargs yabai -m window --focus
fi
