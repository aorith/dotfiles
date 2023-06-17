# vim: ft=bash
[[ "$(uname -s)" != "Darwin" ]] || exit $_SKIP
[[ -z "$CONTAINER_ID" ]] || {
    log_warn "run this outside of a container"
    exit "$_SKIP"
}

cd "$(dirname -- "$0")" || exit 1
./run.sh

exit 0
