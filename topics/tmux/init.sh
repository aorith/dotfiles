# vim: ft=bash

create_link "${PWD}/src/tmux" "$HOME/.config/tmux"

[[ -f "${PWD}/src/tmux/bin/tcdn_server_for_go/tcdn_server_for_go" ]] || {
    log_info "Building 'tcdn_server_for_go' ..."
    type go >/dev/null 2>&1 || {
        log_warn "Go is not installed"
        exit 0
    }

    pushd "${PWD}/src/tmux/bin/tcdn_server_for_go/" >/dev/null &&
        ./build.sh &&
        popd >/dev/null || exit 1
}
