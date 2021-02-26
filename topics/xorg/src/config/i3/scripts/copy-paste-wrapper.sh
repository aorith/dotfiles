#!/bin/bash

active_window=$(xdotool getactivewindow)
active_window_pid=$(xdotool getwindowpid $active_window)
current_window_cmd="$(ps -o cmd= -p $active_window_pid)"

# ${a,,} => lowercase
if [[ ${current_window_cmd,,} =~ (xterm|alacritty|zutty|rxvt|kitty) ]]; then
    case $1 in
        copy) xdotool key --clearmodifiers Control_L+Shift_L+c ;;
        paste) xdotool key --clearmodifiers Shift_L+Insert ;;
        cut) ;;
        *) ;;
    esac
else
    case $1 in
        copy) xdotool key  --clearmodifiers Control_L+c ;;
        paste) xdotool key --clearmodifiers Control_L+v ;;
        cut) xdotool key --clearmodifiers Control_L+x ;;
        *) ;;
    esac
fi

# try to fix modkey getting stuck
xdotool keyup super
