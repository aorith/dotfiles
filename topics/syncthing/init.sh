# vim: ft=bash

# Exceptions
if [[ -d /nix ]] || [[ "$_OS" != "Linux" ]] || [[ ! -d /etc/systemd ]] ; then
    exit $_SKIP
fi
case $HOSTNAME in
    admin-*) exit $_SKIP ;;
    *) ;;
esac

### bootstrap
mkdir -p "${HOME}/.config/systemd/user"
mkdir -p "${HOME}/Syncthing"
create_link "${PWD}/src/syncthing.service" "$HOME/.config/systemd/user/syncthing.service"
systemctl --user daemon-reload
if ! systemctl --user status syncthing.service >/dev/null 2>&1; then
    log_warn "Syncthing can be started/enabled using: 'systemctl --user start/enable syncthing.service'."
fi
###
exit 0
