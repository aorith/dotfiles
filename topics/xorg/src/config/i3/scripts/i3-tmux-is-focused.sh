#!/bin/bash
active_window=$(xdotool getactivewindow)
active_window_pid=$(xdotool getwindowpid $active_window)
current_window_cmd="$(ps -o cmd= -p $active_window_pid)"
[[ ${current_window_cmd,,} =~ xterm.*tmux ]]
