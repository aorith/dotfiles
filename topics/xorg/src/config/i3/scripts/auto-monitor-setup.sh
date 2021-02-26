#!/bin/bash

# intel driver = LVDS1, modesetting driver = LVDS-1
[[ "$(xrandr | grep -w 'connected' | head -1 | awk '{print $1}')" =~ - ]] && D='-' || D=''

# usual ports
LVDS1="LVDS${D}1"
DP1="DP${D}1"
VGA1="VGA${D}1"

connected_monitors="$(xrandr | grep -w connected | awk '{print $1}')"
[[ $connected_monitors =~ LVDS${D}1 ]] && LVDS1_on=1
[[ $connected_monitors =~ DP${D}1 ]] && DP1_on=1
[[ $connected_monitors =~ VGA${D}1 ]] && VGA1_on=1

if [[ -n $DP1_on ]] && [[ -n $VGA1_on ]]; then
    xrandr --output $LVDS1 --auto --off --output $DP1 --primary --mode 2560x1440 --output $VGA1 --auto --right-of $DP1
elif [[ -n $VGA1_on ]]; then
    xrandr --output $LVDS1 --auto --off --output $VGA1 --auto --primary
fi

exit 0
