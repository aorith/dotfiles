# vim: ft=bash

### bootstrap
create_link "${PWD}/config" "$HOME/.config/nvim"
mkdir -p ~/.local/share/nvim/swap
mkdir -p ~/.local/share/nvim/undodir
mkdir -p ~/.local/share/nvim/backup
if ! command -V nvim >/dev/null 2>&1; then
    log_warn "Install with 'nix profile install 'github:aorith/dotfiles?dir=topics/nvim' on non NixOs"
fi
###
exit 0
