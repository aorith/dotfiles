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

case $OSTYPE in
linux*)
    ln -sf "$DOTFILES/topics/shell/bin/pbcopy" "$HOME/.local/bin/pbcopy"
    ln -sf "$DOTFILES/topics/shell/bin/pbpaste" "$HOME/.local/bin/pbpaste"

    if [[ -n "$WAYLAND_DISPLAY" ]] || [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
        mkdir -p "$HOME/.config/environment.d"
        cp "$DOTFILES/topics/shell/etc/common/environment.d/wayland.conf" "$HOME"/.config/environment.d/
    else
        rm -f "$HOME"/.config/environment.d/wayland.conf
    fi
    ;;
darwin*) ;;
*) ;;
esac

ln -sf "$DOTFILES/topics/shell/bin/osccopy" "$HOME/.local/bin/osccopy"
