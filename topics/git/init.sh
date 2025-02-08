# vim: ft=bash

[[ ! -f "$HOME/.gitconfig" ]] || rm "$HOME/.gitconfig"

create_link "${PWD}/src/config/git" "$HOME/.config/git"
create_link "${PWD}/src/config/gitui" "$HOME/.config/gitui"

mkdir -p "$HOME/.local/bin"
# create_link "${PWD}/bin/pager" "$HOME/.local/bin/pager"
