# vim: ft=bash
case $OSTYPE in
linux*)
    if [[ -e /etc/nixos ]]; then
        log_info "Systemd User services do not work on NixOS"
        exit "$_SKIP"
    fi
    ;;
*) exit "$_SKIP" ;;
esac

here=$(dirname -- "$0")
mkdir -p ~/.config/systemd/user/timers.target.wants
mkdir -p ~/.config/systemd/user/default.target.wants

cp "${here}/flatpak/check-flatpak-updates.timer" ~/.config/systemd/user/check-flatpak-updates.timer
cp "${here}/flatpak/check-flatpak-updates.service" ~/.config/systemd/user/check-flatpak-updates.service
rm -f ~/.config/systemd/user/timers.target.wants/check-flatpak-updates.timer
ln -sf "$(realpath -- "${here}/flatpak/check-flatpak-updates.timer")" ~/.config/systemd/user/timers.target.wants/check-flatpak-updates.timer

cp "${here}/keepass/backup-keepass.timer" ~/.config/systemd/user/backup-keepass.timer
cp "${here}/keepass/backup-keepass.service" ~/.config/systemd/user/backup-keepass.service
rm -f ~/.config/systemd/user/timers.target.wants/backup-keepass.timer
ln -sf "$(realpath -- "${here}/keepass/backup-keepass.timer")" ~/.config/systemd/user/timers.target.wants/backup-keepass.timer

cp "${here}/gandi/update-gandi-domain.timer" ~/.config/systemd/user/update-gandi-domain.timer
cp "${here}/gandi/update-gandi-domain.service" ~/.config/systemd/user/update-gandi-domain.service
rm -f ~/.config/systemd/user/timers.target.wants/update-gandi-domain.timer
ln -sf "$(realpath -- "${here}/gandi/update-gandi-domain.timer")" ~/.config/systemd/user/timers.target.wants/update-gandi-domain.timer
