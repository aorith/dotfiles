# vim: ft=bash

[[ "$(uname -s)" == "Linux" ]] || exit "$_SKIP"

create_link "$PWD/src/distrobox" "$HOME/.config/distrobox"
exit 0
