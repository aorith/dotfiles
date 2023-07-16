# vim: ft=bash

[[ "$(uname -s)" == "Linux" ]] || exit "$_SKIP"
type distrobox >/dev/null 2>&1 || { log_warn "distrobox is not installed"; exit "$_SKIP"; }

create_link "$PWD/src/distrobox" "$HOME/.config/distrobox"

if [[ -d /etc/nixos ]]; then
    distrobox assemble create --file "$HOME/githome/dotfiles/topics/distrobox/distrobox_nixos.ini"
else
    distrobox assemble create --file "$HOME/githome/dotfiles/topics/distrobox/distrobox.ini"
fi
exit 0
