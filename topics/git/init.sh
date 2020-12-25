# vim: ft=bash

### bootstrap
symlink_env
create_link "${PWD}/src/git" "$HOME/.config/git"
[[ -f "$HOME/.gitconfig" ]] && rm "$HOME/.gitconfig" || true
###
exit 0
