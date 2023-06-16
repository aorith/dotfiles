# vim: ft=bash

create_link "${PWD}/src/tmux" "$HOME/.config/tmux"

[[ -f "${PWD}/src/tmux/bin/tcdn_server_for_go/tcdn_server_for_go" ]] || {
    pushd "${PWD}/src/tmux/bin/tcdn_server_for_go/" >/dev/null &&
        ./build.sh &&
        popd >/dev/null || exit 1
}
