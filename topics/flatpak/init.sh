# vim: ft=bash
[[ -d /etc/nixos ]] || exit "$_SKIP"
type ansible-playbook >/dev/null 2>&1 || {
    log_warn "ansible is not installed."
    exit "$_SKIP"
}

cd "$(dirname -- "$0")" || exit 1
./run.sh

exit 0
