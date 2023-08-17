# vim: ft=bash

[[ -e ~/Syncthing ]] || exit $_SKIP

log_info "Copying ignore files ..."

base_folder=$(realpath -- ~/Syncthing)
while read -r d; do
    base_dir=$(basename -- "$d")
    [[ "$base_dir" != "_config" ]] || continue

    cp ./src/stignore "${d}/.stignore"
    cp ./src/global-ignore "${d}/global-ignore"
done < <(find "$base_folder" -mindepth 1 -maxdepth 1 -type d)

exit 0
