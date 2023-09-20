{pkgs, ...}: let
  backup-keepass = pkgs.writeShellScriptBin "backup-keepass.sh" ''
    backup_date=$(${pkgs.coreutils}/bin/date +'%Y%m%d%H%M%S')
    sum=$(sha256sum ~/Syncthing/KeePass/0DB/main.kdbx | awk '{print $1}')

    find ~/Syncthing/KeePass/0DB/Backups/ -type f -regex ".*/main_.*_''${sum}\.kdbx"
    if ${pkgs.findutils}/bin/find ~/Syncthing/KeePass/0DB/Backups/ -type f -regex ".*/main_.*_''${sum}\.kdbx" -print0 | grep -q '^'; then
        echo "Backup for ''${sum} already exists."
    else
        echo "Saving backup for ''${sum}."
        cp ~/Syncthing/KeePass/0DB/main.kdbx ~/Syncthing/KeePass/0DB/Backups/main_''${backup_date}_''${sum}.kdbx
    fi

    # keep only 60 backups
    ls -dt ~/Syncthing/KeePass/0DB/Backups/*.kdbx | tail -n +60 | xargs --no-run-if-empty rm
  '';
in {
  # Update gandi domain
  systemd.user.timers."update-gandi-domain" = {
    Unit = {
      Description = "Update Gandi Domain Timer";
    };

    Timer = {
      OnBootSec = "5m";
      OnUnitActiveSec = "12h";
      Unit = "update-gandi-domain.service";
    };

    Install = {
      WantedBy = ["timers.target"];
    };
  };

  systemd.user.services."update-gandi-domain" = {
    Unit = {
      Description = "Update Gandi Domain";
    };
    Service = {
      Type = "oneshot";
      ExecStart = ''${pkgs.bash}/bin/bash /home/aorith/Syncthing/KeePass/iou.re/update-gandi-domain.sh'';
    };
  };

  # Backup keepass
  systemd.user.timers."backup-keepass" = {
    Unit = {
      Description = "Backup KeePass Timer";
    };

    Timer = {
      OnBootSec = "5m";
      OnUnitActiveSec = "12h";
      Unit = "backup-keepass.service";
    };

    Install = {
      WantedBy = ["timers.target"];
    };
  };

  systemd.user.services."backup-keepass" = {
    Unit = {
      Description = "Backup KeePass";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${backup-keepass}/bin/backup-keepass.sh";
    };
  };
}
