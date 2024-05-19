# vim: ft=bash
# To update distroboxes, delete them and run their alias to db-wrapper.

case $OSTYPE in
linux*) ;;
*) exit "$_SKIP" ;;
esac

type distrobox >/dev/null 2>&1 || {
    log_warn "distrobox is not installed"
    exit "$_SKIP"
}

mkdir -p ~/.local/bin
create_link "$PWD/src/distrobox" "$HOME/.config/distrobox"
