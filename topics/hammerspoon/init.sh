# vim: ft=bash

# mac only
[[ "$(uname -s)" == "Darwin" ]] || exit $_SKIP

### bootstrap
create_link "${PWD}/src/hammerspoon" "$HOME/.hammerspoon"
###
exit 0
