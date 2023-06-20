# vim: ft=bash
[[ "$(uname -s)" != "Darwin" ]] || exit $_SKIP
[[ -z "$CONTAINER_ID" ]] || {
    log_warn "run this outside of a container"
    exit "$_SKIP"
}
type -P flatpak >/dev/null 2>&1 || {
    log_warn "flatpak is not installed"
    exit "$_SKIP"
}

cd "$(dirname -- "$0")" || exit 1
./run.sh

exit 0
