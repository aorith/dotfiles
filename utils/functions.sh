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
    add_to_path "/opt/homebrew/opt/coreutils/libexec/gnubin"
    # _link <SOURCE_FILE> <LINK_NAME>
    local _source _link_name _sudo
    _source="$1"
    _link_name="$2"
    [[ "$(uname -s)" == "Darwin" ]] && _canon_link_name="$(readlink -- "${_link_name}")" \
        || _canon_link_name="$(readlink -f "${_link_name}")"
    name="${_link_name/$HOME/\~}"

    # necesito sudo?
    _sudo=''
    if [[ ! -w "$(dirname -- "$_link_name")" ]]; then
        _sudo='sudo'
    fi

    # ya esta linkado?
    if [[ -L $_link_name ]] && [[ "${_canon_link_name}" == "${_source}" ]]; then
        [[ -n "$_sudo" ]] && link_success_sudo "$name" || link_success "$name"
        return 0
    fi

    [[ -L $_link_name ]] && ${_sudo} rm "$_link_name"
    if ${_sudo} ln -Ts "$_source" "$_link_name"; then
        [[ -n "$_sudo" ]] && link_arrow_sudo "$name" || link_arrow "$name"
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
set +a
