#!/usr/bin/env bash

switch_theme_script="${HOME}/.config/alacritty/bin/switch-theme.sh"
dark="mine/github-dark.yml"
light="mine/tempus_day.yml"

if [[ "$(uname -o)" == "Darwin" ]]; then
    if [[ "$(defaults read -g AppleInterfaceStyle)" =~ Dark ]]; then
        "$switch_theme_script" "$dark"
        tmux setenv -g COLORSCHEME_DELTA "darkmode"
    else
        "$switch_theme_script" "$light"
        tmux setenv -g COLORSCHEME_DELTA "lightmode"
    fi
fi

# TODO: Linux
