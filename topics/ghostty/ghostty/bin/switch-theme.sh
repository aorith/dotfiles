#!/bin/sh
set -e

dark_theme="modus-vivendi"
light_theme="modus-operandi"

output="$HOME/.config/ghostty/theme"
if grep -qi 'dark' "$output"; then
    printf '# light\ntheme = %s\n' "$light_theme" >"$output"
else
    printf '# dark\ntheme = %s\n' "$dark_theme" >"$output"
fi

if command -v osascript >/dev/null 2>&1; then
    cat <<EOF | osascript >/dev/null 2>&1
tell application "System Events"
    tell process "Ghostty"
        click menu item "Reload Configuration" of menu "Ghostty" of menu bar item "Ghostty" of menu bar 1
    end tell
end tell
EOF
fi
