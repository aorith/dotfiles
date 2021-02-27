#!/bin/bash

# intel driver = LVDS1, modesetting driver = LVDS-1
[[ "$(xrandr | grep -w 'connected' | head -1 | awk '{print $1}')" =~ - ]] && D='-' || D=''

# usual ports
LVDS1="LVDS${D}1"
DP1="DP${D}1"
VGA1="VGA${D}1"

# resolution
DP1_res="--mode 2560x1440"
#DP1_res="--mode 3840x2160"

connected_monitors="$(xrandr | grep -w connected | awk '{print $1}')"
[[ $connected_monitors =~ LVDS${D}1 ]] && LVDS1_on=1
[[ $connected_monitors =~ DP${D}1 ]] && DP1_on=1
[[ $connected_monitors =~ VGA${D}1 ]] && VGA1_on=1


auto() {
    if [[ -n $DP1_on ]] && [[ -n $VGA1_on ]]; then
        xrandr --output $LVDS1 --auto --off --output $DP1 --primary $DP1_res --output $VGA1 --auto --right-of $DP1
    elif [[ -n $VGA1_on ]]; then
        xrandr --output $LVDS1 --auto --off --output $VGA1 --auto --primary
    fi
}

turn_on() {
    case $1 in
        LVDS1) xrandr --output $LVDS1 --primary --auto ;;
        DP1) xrandr --output $DP1 --primary $DP1_res ;;
        VGA) xrandr --output $VGA1 --primary --auto ;;
        *) ;;
    esac
}

turn_off() {
    case $1 in
        LVDS1) xrandr --output $LVDS1 --off ;;
        DP1) xrandr --output $DP1 --off ;;
        VGA) xrandr --output $VGA1 --off ;;
        *) ;;
    esac
}

case $1 in
    auto) auto ;;
    off) turn_off "$2" ;;
    on) turn_on "$2" ;;
    *) auto ;;
esac
