#!/bin/bash

THEMES=(
    "theme = dark:Ghostty Default StyleDark,light:selenized-light"
    "theme = dark:selenized-black,light:selenized-white"
    "theme = selenized-dark"
    "theme = selenized-black"
    "theme = selenized-light"
    "theme = selenized-white"
    "# Default"
)

theme_file="$HOME/.config/ghostty/theme"

current_index=1
if [ -r "$theme_file" ]; then
    first_line="$(head -n 1 "$theme_file")"
    if [[ "$first_line" =~ ^#\ ([0-9]+)$ ]]; then
        current_index=${BASH_REMATCH[1]}
    fi
fi

if [ "$current_index" -lt 1 ] || [ "$current_index" -gt ${#THEMES[@]} ]; then
    current_index=1
fi
next_index=$(((current_index % ${#THEMES[@]}) + 1))
next_value="${THEMES[next_index - 1]}"

echo "# $next_index" >"$theme_file"
echo "$next_value" >>"$theme_file"

cat <<EOF | osascript >/dev/null 2>&1
tell application "System Events"
    tell process "Ghostty"
        click menu item "Reload Configuration" of menu "Ghostty" of menu bar item "Ghostty" of menu bar 1
    end tell
end tell
EOF

tmux display-message "  $next_index/${#THEMES[@]}: $next_value"
