# vim: ft=bash

case $OSTYPE in
linux*) true ;;
*) exit "$_SKIP" ;;
esac

type -P flatpak >/dev/null 2>&1 || {
    log_warn "flatpak is not installed"
    exit "$_SKIP"
}

cd "$(dirname -- "$0")" || exit 1
./run.sh

exit 0
