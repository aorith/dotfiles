# vim: ft=bash

# macos only
case $OSTYPE in
darwin*) true ;;
*)
    log_skip "macos"
    exit 0
    ;;
esac

# Fix Option+Space inserting non-breaking space (0xA0) " "
# UPDATE: doesn't work reliably, fixed directly in alacritty
#mkdir -p ~/Library/KeyBindings
#cp "${PWD}/src/DefaultKeyBinding.Dict" "$HOME/Library/KeyBindings/DefaultKeyBinding.Dict"

# KeyRepeat
defaults write -g InitialKeyRepeat -int 13
defaults write -g KeyRepeat -int 2

# https://tonsky.me/blog/monitors/
#defaults write -g AppleFontSmoothing -int 0
