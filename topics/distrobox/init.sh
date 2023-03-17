# vim: ft=bash

if [[ ! -d /etc/nixos ]] && [[ ! -e /etc/rpm-ostreed.conf ]]; then
    exit "$_SKIP"
fi

mkdir ~/.local/bin
create_link "${PWD}/src/distrobox" "$HOME/.config/distrobox"
if [[ ! -e "$HOME/.local/bin/nvim" ]]; then
    log_warn "File $HOME/.local/bin/nvim not found, run this command inside of distrobox: 'distrobox-export --bin /usr/bin/nvim --export-path ~/.local/bin'."
fi

###
exit 0
