# vim: ft=bash
set -e

[[ -e ~/Syncthing ]] || exit "$_SKIP"

log_info "Copying ignore files ..."

base_folder=$(realpath -- ~/Syncthing)
while read -r d; do
    base_dir=$(basename -- "$d")
    [[ "$base_dir" != "_config" ]] || continue

    cp ./src/stignore "${d}/.stignore"
    cp ./src/global-ignore "${d}/global-ignore"
done < <(find "$base_folder" -mindepth 1 -maxdepth 1 -type d)

[[ ! -d /etc/nixos ]] || exit 0

case "$HOSTNAME" in
trantor | alpaca)
    if [[ ! -e "${PWD}/src/quadlet/syncthing.${HOSTNAME}.env" ]]; then
        log_warn "Env file not present: '${PWD}/src/quadlet/syncthing.${HOSTNAME}.env'"
        exit 1
    fi
    ;;
*) exit 0 ;;
esac

log_info "Copying quadlet files ..."
mkdir -p ~/.config/containers/systemd/syncthing
cp "${PWD}/src/quadlet/syncthing.container" "$HOME/.config/containers/systemd/syncthing/syncthing.container"
cp "${PWD}/src/quadlet/syncthing.${HOSTNAME}.env" "$HOME/.config/containers/systemd/syncthing/syncthing.env"
systemctl --user daemon-reload
systemctl --user start syncthing

exit 0
