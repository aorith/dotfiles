# vim: ft=bash

# Conditions
if [[ "$(uname -s)" != "Linux" ]] || [[ ! -d /etc/X11 ]]; then
    exit $_SKIP
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

            create_link "${PWD}/src/xsession" "${HOME}/.xsession"
        fi
        ;;
    *) exit $_SKIP ;;
esac
###
exit 0
