# vim: ft=bash

case $OSTYPE in
linux*)
    if [[ -d /etc/nixos ]]; then
        db_ini="distrobox-nixos.ini"
    else
        db_ini="distrobox.ini"
    fi
    ;;
*) exit "$_SKIP" ;;
esac

type distrobox >/dev/null 2>&1 || {
    log_warn "distrobox is not installed"
    exit "$_SKIP"
}

mkdir -p ~/.local/bin
create_link "$PWD/src/distrobox" "$HOME/.config/distrobox"

distrobox assemble create --replace --file "$HOME/githome/dotfiles/topics/distrobox/${db_ini}"
