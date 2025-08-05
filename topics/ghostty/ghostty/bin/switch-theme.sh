#!/bin/sh

THEME_FILE="$HOME/.config/ghostty/theme"
theme="$(
    echo "# Default
theme = dark:Ghostty Default StyleDark,light:selenized-light
theme = dark:selenized-black,light:selenized-white
theme = selenized-dark
theme = selenized-black
theme = selenized-light
theme = selenized-white" |
        fzf --layout=reverse --tmux
)"

[ -n "$theme" ] || exit 0

echo "$theme" >"$THEME_FILE"

if command -v osascript >/dev/null 2>&1; then
    cat <<EOF | osascript >/dev/null 2>&1
tell application "System Events"
    tell process "Ghostty"
        click menu item "Reload Configuration" of menu "Ghostty" of menu bar item "Ghostty" of menu bar 1
    end tell
end tell
EOF
fi
