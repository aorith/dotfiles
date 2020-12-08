#!/usr/bin/env bash

colors=( 
    $(find ~/.config/kitty/themes -name "*.conf" 2>/dev/null)
)
color="${colors[$RANDOM % ${#colors[@]} ]}"

echo "${color}" > ~/.config/kitty/scripts/current_theme
kitty @ set_colors --reset --all
kitty @ set_colors --all --configured ${color}
