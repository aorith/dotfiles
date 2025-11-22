# vim: ft=bash

case $OSTYPE in
linux*) true ;;
*)
    log_skip "flatpak"
    exit 0
    ;;
esac

command -v flatpak >/dev/null 2>&1 || {
    log_warn "flatpak is not installed"
    log_skip "flatpak"
    exit 0
}

cd "$(dirname -- "$0")" || exit 1
./run.sh

exit 0
