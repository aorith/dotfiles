#!/usr/bin/env bash
PATH="/usr/local/bin:/bin:/usr/bin"

if [[ "$1" == "reset" ]]; then
    kitty @ set-colors --reset --all
else
    cd ~/.config/kitty/themes || exit 1
    find . -type f -name "*.conf" -not -name "template.conf" | fzf --preview "head -n 100 {} && kitty @ set-colors -a -c {}"
fi
