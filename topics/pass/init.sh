# vim: ft=bash

### bootstrap
[[ -e ~/Syncthing ]] || {
    # shellcheck disable=SC2088
    log_warn "~/Syncthing does not exist"
    exit "$_SKIP"
}

create_link "${HOME}/Syncthing/KeePass/gpg/pass/store" "$HOME/.password-store"
