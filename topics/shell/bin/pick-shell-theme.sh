#!/usr/bin/env bash
set -e

BASET="$HOME/.config/tinted-theming/tinted-shell/scripts"
cd "$BASET" || exit 1

{
    find . -type f -name "base*.sh"
} | fzf --preview "bat {} && ln -sf '$BASET/$(basename {})' '$HOME/.config/tinted-shell-theme.sh'"

bash "$HOME/.config/tinted-shell-theme.sh"
