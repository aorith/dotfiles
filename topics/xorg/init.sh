# vim: ft=bash

# Conditions
if [[ "$(uname -s)" != "Linux" ]] || [[ ! -d /etc/X11 ]]; then
    exit 0
fi

###
case $HOSTNAME in
    x220)
        if [[ "$XDG_CURRENT_DESKTOP" == "GNOME" ]]; then
            log_info "... gnome detected."
            # dconf backup and restore
            # dconf dump /org/gnome/desktop/ > gnome-desktop.conf
            # dconf load /org/gnome/desktop/ < gnome-desktop.conf

            # keyboard settings
            dconf load /org/gnome/desktop/wm/keybindings/ < "${PWD}/etc/gnome/dconf/gnome-keybindings.conf"
            dconf load /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ < "${PWD}/etc/gnome/dconf/custom-keybindings.conf"
        else
            log_info "... unknown wm detected, linking extra configs."
            for f in "${PWD}/src/config/"*; do
                create_link "${f}" "${HOME}/.config/$(basename "$f")"
            done
            unset f

            # Exceptions that should not be applied on NixOS
            if [[ ! $(uname -a) =~ NixOS ]]; then
                sudo localectl --no-convert set-x11-keymap es
                sudo mkdir -p "/etc/X11/xorg.conf.d"
                # create_link "${PWD}/etc/X11/xorg.conf.d/20-intel.conf" "/etc/X11/xorg.conf.d/20-intel.conf"
                create_link "${PWD}/etc/modprobe.d/i915.conf" "/etc/modprobe.d/i915.conf"
            fi
        fi
        ;;
    *) ;;
esac
###
unset _create_user_dirs
exit 0
