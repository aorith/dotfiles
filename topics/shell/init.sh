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

# ZSH
# create_link "${PWD}/src/zsh/.zshenv" "$HOME/.zshenv"
# create_link "${PWD}/src/zsh" "$HOME/.config/zsh"
# mkdir -p "${XDG_CACHE_HOME:-$HOME/.cache}"/zsh

# STARSHIP
create_link "${PWD}/src/starship.toml" "$HOME/.config/starship.toml"

# TINTED SHELL
if [[ -d "$HOME/.config/tinted-theming/tinted-shell" ]]; then
    (cd "$HOME/.config/tinted-theming/tinted-shell" && git pull) >/dev/null
else
    git clone https://github.com/tinted-theming/tinted-shell.git \
        "$HOME/.config/tinted-theming/tinted-shell"
fi
