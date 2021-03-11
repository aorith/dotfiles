# vim: ft=bash

# Linux only
[[ "$(uname -s)" != "Linux" ]] && exit 0

_create_user_dirs() {
    . "$PWD/src/config/user-dirs.dirs"
    for d in $(awk -F'=' '{print $1}' < "${PWD}/src/config/user-dirs.dirs"); do
        mkdir -p "${!d}"
    done
}

###
case $HOSTNAME in
    x220)
        create_link "${PWD}/src/config/fontconfig" "$HOME/.config/fontconfig"
        create_link "${PWD}/src/config/Xresources" "$HOME/.config/Xresources"
        create_link "${PWD}/src/config/i3" "$HOME/.config/i3"
        create_link "${PWD}/src/config/gsimplecal" "$HOME/.config/gsimplecal"
        create_link "${PWD}/src/config/dunst" "$HOME/.config/dunst"
        create_link "${PWD}/src/config/user-dirs.dirs" "$HOME/.config/user-dirs.dirs"
        _create_user_dirs
        create_link "${PWD}/src/xinitrc" "$HOME/.xinitrc"
        sudo mkdir -p "/etc/X11/xorg.conf.d"
        # create_link "${PWD}/etc/X11/xorg.conf.d/20-intel.conf" "/etc/X11/xorg.conf.d/20-intel.conf"
        create_link "${PWD}/etc/modprobe.d/i915.conf" "/etc/modprobe.d/i915.conf"
        sudo localectl --no-convert set-x11-keymap es
        ;;
    *) ;;
esac
###
unset _create_user_dirs
exit 0
