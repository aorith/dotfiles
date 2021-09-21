# vim: ft=bash

### bootstrap
create_link "${PWD}/src/vim" "$HOME/.vim"
mkdir -p ~/.local/share/vim/swap
mkdir -p ~/.local/share/vim/undodir
mkdir -p ~/.local/share/vim/backup
###
exit 0
