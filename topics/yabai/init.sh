# vim: ft=bash

# macos only
[[ "$(uname -s)" == "Darwin" ]] || exit "$_SKIP"

create_link "${PWD}/src/yabai" "$HOME/.config/yabai"
create_link "${PWD}/src/skhd" "$HOME/.config/skhd"
