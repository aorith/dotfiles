# vim: ft=bash

### bootstrap
create_link "${PWD}/src/alacritty" "$HOME/.config/alacritty"
create_link "${PWD}/src/alacritty/$(uname -s).toml" "${PWD}/src/alacritty/env.toml"
###
exit 0
