# vim: ft=bash

mkdir -p ~/.local/bin

# BASH
mkdir -p ~/.local/share/zsh
create_link "${PWD}/src/inputrc" "$HOME/.inputrc"

create_link "${PWD}/src/bash/bashrc" "$HOME/.bashrc"
create_link "${PWD}/src/bash/bash_profile" "$HOME/.bash_profile"

source "${PWD}/etc/common/env.sh"
if [[ -n "$GOBIN" ]]; then
    mkdir -p "$GOBIN"
fi

# STARSHIP
create_link "${PWD}/src/starship.toml" "$HOME/.config/starship.toml"
