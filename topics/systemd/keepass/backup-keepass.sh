#!/bin/sh
export PATH="/bin:/usr/bin:$PATH"

command -v openssl >/dev/null || exit 1

backup_date=$(date +'%Y%m%d%H%M%S')
sum=$(openssl sha256 ~/Syncthing/KeePass/0DB/main.kdbx | awk '{print $NF}' | head -1)

find ~/Syncthing/KeePass/0DB/Backups/ -type f -regex ".*/main_.*_${sum}\.kdbx"
if find ~/Syncthing/KeePass/0DB/Backups/ -type f -regex ".*/main_.*_${sum}\.kdbx" -print0 | grep -q '^'; then
    echo "Backup for ${sum} already exists."
else
    echo "Saving backup for ${sum}."
    cp ~/Syncthing/KeePass/0DB/main.kdbx ~/Syncthing/KeePass/0DB/Backups/"main_${backup_date}_${sum}.kdbx"
fi

# keep only 60 backups
find ~/Syncthing/KeePass/0DB/Backups/ -name '*.kdbx' -type f -printf '%T@ %p\n' | sort -n | tail -n +60 | awk '{print $NF}' | xargs --no-run-if-empty rm
