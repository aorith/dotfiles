#!/bin/bash

# $1 = i3 syntax (left,right,up,down)
# $2 = tmux syntax (left,right,top,bottom)

if ~/.config/i3/scripts/i3-tmux-is-focused.sh; then
    if tmux_pane_at ${2}; then
        case $2 in
            left) tmux select-pane -L & ;;
            right) tmux select-pane -R & ;;
            top) tmux select-pane -U & ;;
            bottom) tmux select-pane -D & ;;
            *) ;;
        esac
    else
        i3-msg focus ${1} &>/dev/null
    fi
else
    i3-msg focus ${1} &>/dev/null
fi
