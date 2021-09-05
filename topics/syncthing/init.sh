# vim: ft=bash

if [[ -d /nix ]] || [[ "$_OS" != "Linux" ]] || [[ ! -d /etc/systemd ]] ; then
    exit 0
fi

### bootstrap
mkdir -p "${HOME}/.config/systemd/user"
create_link "${PWD}/src/syncthing.service" "$HOME/.config/systemd/user/syncthing.service"
systemctl --user daemon-reload
if ! systemctl --user status syncthing.service >/dev/null 2>&1; then
    log_warn "Syncthing can be started/enabled using: 'systemctl --user start/enable syncthing.service'."
fi
###
exit 0
