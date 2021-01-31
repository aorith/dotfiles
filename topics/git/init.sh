# vim: ft=bash

### bootstrap
create_link "${PRIVATE_GITHOME}" "${GITHOME}/00_SYNC"
create_link "${PWD}/src/git" "$HOME/.config/git"
[[ -f "$HOME/.gitconfig" ]] && rm "$HOME/.gitconfig" || true
###
exit 0
