# vim: ft=bash

### bootstrap
[[ -d $PRIVATE_GITHOME ]] && create_link "${PRIVATE_GITHOME}" "${GITHOME}/00_SYNC" || true
create_link "${PWD}/src/git" "$HOME/.config/git"
[[ -f "$HOME/.gitconfig" ]] && rm "$HOME/.gitconfig" || true
###
exit 0
