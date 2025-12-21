#!/bin/sh
export PATH="/bin:/usr/bin:$PATH"

keepass_dir="$HOME/Syncthing/KeePass/0DB"
if [ ! -d "$keepass_dir" ]; then
    keepass_dir="/var/lib/syncthing/KeePass/0DB"
fi
if [ ! -d "$keepass_dir" ]; then
    exit 1
fi

command -v openssl >/dev/null || exit 1

backup_date=$(date +'%Y%m%d%H%M%S')
sum=$(openssl sha256 "$keepass_dir/main.kdbx" | awk '{print $NF}' | head -1)

find "$keepass_dir/Backups/" -type f -regex ".*/main_.*_${sum}\.kdbx"
if find "$keepass_dir/Backups/" -type f -regex ".*/main_.*_${sum}\.kdbx" -print0 | grep -q '^'; then
    echo "Backup for ${sum} already exists."
else
    echo "Saving backup for ${sum}."
    cp "$keepass_dir/main.kdbx" "$keepass_dir/Backups/main_${backup_date}_${sum}.kdbx"
fi

# keep only 60 backups
find "$keepass_dir/Backups/" -name '*.kdbx' -type f -printf '%T@ %p\n' | sort -n | tail -n +60 | awk '{print $NF}' | xargs --no-run-if-empty rm
