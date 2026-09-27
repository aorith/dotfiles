# vim: ft=bash

# macos only
case $OSTYPE in
darwin*) true ;;
*)
    log_skip "macos"
    exit 0
    ;;
esac

# KeyRepeat
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2

# https://tonsky.me/blog/monitors/
#defaults write -g AppleFontSmoothing -int 0

if ! [[ -f "$HOME/Library/Fonts/Symbola.ttf" ]]; then
    set -x
    mkdir -p "$HOME/Library/Fonts"
    curl -fsSL -o "$HOME/Library/Fonts/Symbola.ttf" "https://zhm.github.io/symbola/fonts/Symbola.ttf"
    set +x
fi
