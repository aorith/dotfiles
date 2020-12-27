# vim: ft=bash

### bootstrap
create_link "${PWD}/src/bashrc" "$HOME/.bashrc"
create_link "${PWD}/src/profile" "$HOME/.profile"
create_link "${PWD}/src/bash_profile" "$HOME/.bash_profile"

create_link "${PWD}/src/zshenv" "$HOME/.zshenv"
mkdir -p ~/.config/zsh
create_link "${PWD}/src/zsh/zshenv" "$HOME/.config/zsh/.zshenv"
create_link "${PWD}/src/zsh/zshrc" "$HOME/.config/zsh/.zshrc"
create_link "${PWD}/src/zsh/zprofile" "$HOME/.config/zsh/.zprofile"
###
exit 0
