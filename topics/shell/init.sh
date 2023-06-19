# vim: ft=bash

mkdir -p ~/.local/share/zsh
create_link "${PWD}/src/inputrc" "$HOME/.inputrc"
create_link "${PWD}/src/bash/bashrc" "$HOME/.bashrc"
create_link "${PWD}/src/bash/bash_profile" "$HOME/.bash_profile"

create_link "${PWD}/src/zsh/.zshenv" "$HOME/.zshenv"
create_link "${PWD}/src/zsh" "$HOME/.config/zsh"
