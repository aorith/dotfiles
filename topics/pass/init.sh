# vim: ft=bash

### bootstrap
[[ -e ~/Syncthing ]] || exit "$_SKIP"
create_link "${HOME}/Syncthing/KeePass/gpg/pass/store" "$HOME/.password-store"
