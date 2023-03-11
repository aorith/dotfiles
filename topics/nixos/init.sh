# vim: ft=bash
[[ -d /etc/nixos ]] || exit "$_SKIP"

mkdir ~/.local/bin
create_link "${PWD}/src/distrobox" "$HOME/.config/distrobox"
if [[ ! -e "$HOME/.local/bin/nvim" ]]; then
    log_warn "File $HOME/.local/bin/nvim not found, run this command inside of distrobox: 'distrobox-export --bin /usr/bin/nvim --export-path ~/.local/bin'."
fi

###
exit 0
