#!/usr/bin/env bash
my_term='Alacritty'
terminal_ids="$(xdotool search --class ${my_term})"
[[ -n "$terminal_ids" ]] || { "${my_term,,}" &  exit 0 ;}
focused_window_id="$(xdotool getwindowfocus)"
for t in $terminal_ids; do
    if [[ "${t#*$focused_window_id}" == "$t" ]]; then
        wmctrl -x -R ${my_term}
    else
        xdotool windowminimize ${t}
    fi
done
