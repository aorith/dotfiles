# vim: ft=bash

### bootstrap
create_link "${PWD}/src/nvim" "$HOME/.config/nvim"
mkdir -p ~/.local/share/nvim/swap
mkdir -p ~/.local/share/nvim/undodir
mkdir -p ~/.local/share/nvim/backup
###
exit 0
