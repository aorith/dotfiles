#!/usr/bin/env bash

if ! xdotool search --classname XTermScratchpad &>/dev/null; then
    xterm \
        -bg '#212121' -fs 12 -name 'XTermScratchpad' \
        -e 'tmux -u new-session -A -s "scratchpad"' &
    sleep 0.3
fi

i3-msg '[instance="XTermScratchpad"] scratchpad show; move position center' &>/dev/null
