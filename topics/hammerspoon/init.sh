# vim: ft=bash

# mac only
[[ "$(uname -s)" != "Darwin" ]] && exit 0

### bootstrap
create_link "${PWD}/src/hammerspoon" "$HOME/.hammerspoon"
###
exit 0
