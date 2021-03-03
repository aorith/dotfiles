#!/bin/bash

if ! xdotool search --classname 'scratchpad.tmux' &>/dev/null; then
    xterm -bg '#212121' -fs 12 -name 'scratchpad.tmux' \
        -e 'tmux -u new-session -A -s "scratchpad"' &
    sleep 0.3
    i3-msg '[instance="scratchpad.tmux"] scratchpad show; move position center' &>/dev/null
else
    i3-msg '[instance="scratchpad.tmux"] scratchpad show' &>/dev/null
fi
