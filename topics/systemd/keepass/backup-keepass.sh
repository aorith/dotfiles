#!/usr/bin/env bash
export PATH="/usr/bin:$PATH"

backup_date=$(date +'%Y%m%d%H%M%S')
sum=$(sha256sum ~/Syncthing/KeePass/0DB/main.kdbx | awk '{print $1}')

find ~/Syncthing/KeePass/0DB/Backups/ -type f -regex ".*/main_.*_${sum}\.kdbx"
if find ~/Syncthing/KeePass/0DB/Backups/ -type f -regex ".*/main_.*_${sum}\.kdbx" -print0 | grep -q '^'; then
    echo "Backup for ${sum} already exists."
else
    echo "Saving backup for ${sum}."
    cp ~/Syncthing/KeePass/0DB/main.kdbx ~/Syncthing/KeePass/0DB/Backups/"main_${backup_date}_${sum}.kdbx"
fi

# keep only 60 backups
ls -dt ~/Syncthing/KeePass/0DB/Backups/*.kdbx | tail -n +60 | xargs --no-run-if-empty rm
