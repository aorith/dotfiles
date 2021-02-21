#!/bin/bash

connected_monitors="$(xrandr | grep -w connected | awk '{print $1}')"
[[ $connected_monitors =~ LVDS1 ]] && LVDS1=1
[[ $connected_monitors =~ DP1 ]] && DP1=1
[[ $connected_monitors =~ VGA1 ]] && VGA1=1

if [[ -n $DP1 ]] && [[ -n $VGA1 ]]; then
    xrandr --output LVDS1 --auto --off --output DP1 --primary --mode 2560x1440 --output VGA1 --auto --right-of DP1
elif [[ -n $VGA1 ]]; then
    xrandr --output LVDS1 --auto --off --output VGA1 --auto --primary
fi

exit 0
