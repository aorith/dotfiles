# vim: ft=bash
[[ -d /etc/nixos ]] || exit "$_SKIP"

cd "$(dirname -- "$0")" || exit 1
./run.sh

exit 0
