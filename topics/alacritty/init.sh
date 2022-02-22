# vim: ft=bash

### bootstrap
[[ -d "$HOME/.config/alacritty" ]] || mkdir -p "$HOME/.config/alacritty"
create_link "${PWD}/src/alacritty" "$HOME/.config/alacritty"
create_link "${PWD}/src/alacritty/$(uname -s).yml" "${PWD}/src/alacritty/env.yml"
###
exit 0
