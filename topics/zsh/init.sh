# vim: ft=bash

### bootstrap
symlink_env
create_link "${PWD}/src/zshrc" "$HOME/.zshrc"
create_link "${PWD}/src/zprofile" "$HOME/.zprofile"
###
exit 0
