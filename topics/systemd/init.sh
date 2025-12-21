# vim: ft=bash
case $OSTYPE in
linux*)
    if [[ -e /etc/nixos ]]; then
        log_info "Systemd User services do not work on NixOS"
        log_skip "systemd"
        exit 0
    fi
    ;;
*)
    log_skip "systemd"
    exit 0
    ;;
esac

case $HOSTNAME in
trantor)
    folders=("flatpak" "cleanup" "gandi")
    ;;
*)
    folders=("flatpak" "cleanup")
    ;;
esac

here="$(dirname -- "$(readlink -f "$0")")"
folders=("flatpak" "gandi" "cleanup")
config_dir="$HOME/.config/systemd/user"
timers_target_dir="$config_dir/timers.target.wants"
mkdir -p "$timers_target_dir"

for folder in "${folders[@]}"; do
    folder="${here}/${folder}"
    [[ -d "$folder" ]] || {
        log_error "Folder '$folder' not found."
        exit 1
    }

    for file in "$folder"/*.service "$folder"/*.timer; do
        if [ -f "$file" ]; then
            base_name=$(basename -- "$file")
            cp "$file" "$config_dir/"

            if [[ "$file" =~ \.timer$ ]]; then
                create_link "$config_dir/$base_name" "$timers_target_dir/$base_name"
            fi
        fi
    done
done

systemctl --user daemon-reload
