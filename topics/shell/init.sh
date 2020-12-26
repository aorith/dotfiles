# vim: ft=bash

### bootstrap
create_link "${PWD}/src/bashrc" "$HOME/.bashrc"
create_link "${PWD}/src/profile" "$HOME/.profile"
create_link "${PWD}/src/bash_profile" "$HOME/.bash_profile"
create_link "${PWD}/src/zshrc" "$HOME/.zshrc"
create_link "${PWD}/src/zprofile" "$HOME/.zprofile"
###
exit 0
