{pkgs, ...}: let
  check-flatpak-updates = pkgs.writeShellScriptBin "check-flatpak-updates.sh" ''
    export PATH="/home/aorith/.nix-profile/bin:/run/current-system/sw/bin:$PATH"
    updates=()
    for n in $(flatpak remote-ls --user --updates); do
        updates+=("$n")
    done

    if ((''${#updates} > 0)); then
        notify-send -i "/usr/share/icons/HighContrast/32x32/apps/system-software-update.png" "Flatpak: updates available\n''${updates[*]}"
        sleep 1
        notify-send -i "/usr/share/icons/HighContrast/32x32/apps/system-software-update.png" "Flatpak: updating ..."
        flatpak --user uninstall --unused -y --noninteractive
        flatpak --user update -y --noninteractive
        flatpak --user repair
        notify-send -i "/usr/share/icons/HighContrast/32x32/apps/system-software-update.png" "Flatpak: done!"
    fi
  '';
in {
  # Notify on flatpak updates
  systemd.user.timers."check-flatpak-updates" = {
    Unit = {
      Description = "Check Flatpak Updates Timer";
    };

    Timer = {
      OnBootSec = "6m";
      OnUnitActiveSec = "2h";
      Unit = "check-flatpak-updates.service";
    };

    Install = {
      WantedBy = ["timers.target"];
    };
  };

  systemd.user.services."check-flatpak-updates" = {
    Unit = {
      Description = "Check Flatpak Updates";
    };
    Service = {
      Environment = [
        "DISPLAY=:0"
        "DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus"
      ];
      Type = "oneshot";
      ExecStart = "${check-flatpak-updates}/bin/check-flatpak-updates.sh";
    };
  };
}
