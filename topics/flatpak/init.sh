# vim: ft=bash
[[ -z "$CONTAINER_ID" ]] || {
    log_warn "run this outside of a container"
    exit "$_SKIP"
}

cd "$(dirname -- "$0")" || exit 1
./run.sh

exit 0
