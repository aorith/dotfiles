# vim: ft=bash

# macos only
[[ "$(uname -s)" != "Darwin" ]] && exit 0

# Workaround to disable cmd+h on kitty
if ! defaults read net.kovidgoyal.kitty NSUserKeyEquivalents 2>/dev/null | grep -q "Hide kitty"; then
    defaults write net.kovidgoyal.kitty NSUserKeyEquivalents -dict-add "Hide kitty" '~^$\\U00a7' 2>/dev/null
fi

exit 0
