# vim: ft=bash

# macos only
[[ "$(uname -s)" == "Darwin" ]] || exit "$_SKIP"

# Fix Option+Space inserting non-breaking space (0xA0) " "
mkdir -p ~/Library/KeyBindings
create_link "${PWD}/src/DefaultKeyBinding.dict" "$HOME/Library/KeyBindings/DefaultKeyBinding.dict"
