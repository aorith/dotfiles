#!/usr/bin/env bash

set -a
_backup() {
    # _backup <FILE_PATH>
    [[ -z "$1" ]] && exit 1

    BACKUP_DIR="$HOME/.bootstrap_backups"
    [[ ! -d "$BACKUP_DIR" ]] && mkdir -p "$BACKUP_DIR"

    # /home/user/.config/.file -> _.config_.file
    BACKUP_NAME="${1/$HOME/}"
    BACKUP_NAME="${BACKUP_NAME////_}"


    if [[ ! -L $1 ]] && [[ -e $1 ]]; then
        mv "${1}" "${BACKUP_DIR}/${BACKUP_NAME}" \
            && link_arrow "Backup for $(basename "$1") done." \
            && return 0
        link_error "Backup for $(basename "$1") failed."
        exit 1
    fi
}

_link() {
    # _link <SOURCE_FILE> <LINK_NAME>
    source="$1"
    link_name="$2"
    name="${1##*src/}"

    # ya esta linkado?
    [[ -L $link_name ]] && [[ "$(readlink -- "${link_name}")" == "${source}" ]] \
        && link_success "$name" && return 0

    [[ -L $link_name ]] && rm "$link_name"
    if ln -s "$source" "$link_name"; then
        link_arrow "$name"
        return 0
    else
        link_error "$name"
        exit 1
    fi
}

create_link() {
    # create_link <SOURCE_FILE> <DEST_FILE>
    [[ $# -ne 2 ]] && exit 1
    [[ ! -r "$1" ]] && { link_error "$1 does not exists."; exit 1; }
    _backup "${2}"
    _link "${1}" "${2}"
}

symlink_env() {
    local topic
    topic="$(basename $PWD)"
    for env_file in env/*; do
        ln -sf "${PWD}/$env_file" "${ENV_FILES_FOLDER}/$(basename ${env_file})_${topic}"
    done
}
set +a
