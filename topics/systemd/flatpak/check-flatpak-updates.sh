#!/usr/bin/env bash
export PATH="/usr/bin:$PATH"

updates=()
for n in $(flatpak remote-ls --user --updates); do
    updates+=("$n")
done

if ((${#updates} > 0)); then
    #notify-send -i "/usr/share/icons/HighContrast/32x32/apps/system-software-update.png" "Flatpak: updates available\n${updates[*]}"
    #sleep 1
    #notify-send -i "/usr/share/icons/HighContrast/32x32/apps/system-software-update.png" "Flatpak: updating ..."
    flatpak --user uninstall --unused -y --noninteractive &&
        flatpak --user update -y --noninteractive &&
        flatpak --user repair && exit 0
    notify-send -i "/usr/share/icons/HighContrast/32x32/apps/system-software-update.png" "FLATPAK UPDATE FAILED.\n${updates[*]}"
fi
