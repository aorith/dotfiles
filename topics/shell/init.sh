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

case $OSTYPE in
linux*)
    if [[ -n "$WAYLAND_DISPLAY" ]] || [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
        ln -sf "$DOTFILES/topics/shell/bin/wl-copy" ~/.local/bin/pbcopy
        ln -sf "$DOTFILES/topics/shell/bin/wl-paste" ~/.local/bin/pbpaste
        mkdir -p "$HOME/.config/environment.d"
        cp "$DOTFILES/topics/shell/etc/common/environment.d/wayland.conf" "$HOME"/.config/environment.d/
    else
        ln -sf "$DOTFILES/topics/shell/bin/xcopy" ~/.local/bin/pbcopy
        ln -sf "$DOTFILES/topics/shell/bin/xpaste" ~/.local/bin/pbpaste
        rm -f "$HOME"/.config/environment.d/wayland.conf
    fi
    ;;
darwin*) ;;
*) ;;
esac

ln -sf "$DOTFILES/topics/shell/bin/osccopy" ~/.local/bin/osccopy
