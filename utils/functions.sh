#!/usr/bin/env bash

set -a
_prepend_to_path() {
    [[ -n "$1" ]] || return 0
    case ":${MY_PATH:-unset}:" in
    *":${1}:"*) ;;             # already there
    ":unset:") MY_PATH="$1" ;; # was empty
    *) MY_PATH="${1}:${MY_PATH}" ;;
    esac
    export MY_PATH
}

_prepend_to_path_commit() {
    export PATH="${MY_PATH}:${PATH}"
    unset MY_PATH
}

_append_to_path() {
    [[ -n "$1" ]] || return 0
    case ":${PATH:-unset}:" in
    *":${1}:"*) ;;             # already there
    ":unset:") MY_PATH="$1" ;; # was empty
    *) PATH="${PATH}:${1}" ;;
    esac
    export PATH
}

_backup() {
    # _backup <FILE_PATH>
    [[ -n "$1" ]] || exit 1

    BACKUP_DIR="$HOME/.bootstrap_backups"
    [[ -d "$BACKUP_DIR" ]] || mkdir -p "$BACKUP_DIR"

    # /home/user/.config/.file -> _.config_.file
    BACKUP_NAME="${1/$HOME/}"
    BACKUP_NAME="${BACKUP_NAME////_}"

    if [[ ! -L "$1" ]] && [[ -e "$1" ]]; then
        mv "${1}" "${BACKUP_DIR}/${BACKUP_NAME}" &&
            link_arrow "Backup for $(basename "$1") done." &&
            return 0
        link_error "Backup for $(basename "$1") failed."
        exit 1
    fi
}

_link() {
    _prepend_to_path "/opt/homebrew/opt/coreutils/libexec/gnubin"
    # _link <SOURCE_FILE> <LINK_NAME>
    local _source _link_name _sudo
    _source="$1"
    _link_name="$2"

    case $OSTYPE in
    darwin*) _canon_link_name="$(readlink -- "${_link_name}")" ;;
    linux*) _canon_link_name="$(readlink -f "${_link_name}")" ;;
    *)
        echo "Unknown OS '$OSTYPE'"
        exit 1
        ;;
    esac
    local name
    name="${_link_name/$HOME/\~}"

    # need sudo?
    _sudo=''
    if [[ ! -w "$(dirname -- "$_link_name")" ]]; then
        _sudo='sudo'
    fi

    # already linked?
    if [[ -L $_link_name ]] && [[ "${_canon_link_name}" == "${_source}" ]]; then
        if [[ -n "$_sudo" ]]; then
            link_success_sudo "$name"
        else
            link_success "$name"
        fi
        return 0
    fi

    [[ ! -L $_link_name ]] || ${_sudo} rm "$_link_name"
    [[ ! -d "$_link_name" ]] || {
        link_error "Target is a directory: '$_link_name'."
        exit 1
    }
    if ${_sudo} ln -s "$_source" "$_link_name"; then
        if [[ -n "$_sudo" ]]; then
            link_arrow_sudo "$name"
        else
            link_arrow "$name"
        fi
        return 0
    else
        link_error "$name"
        exit 1
    fi
}

create_link() {
    # create_link <SOURCE_FILE> <DEST_FILE>
    [[ $# -eq 2 ]] || exit 1
    [[ -r "$1" ]] || {
        link_error "$1 does not exists."
        exit 1
    }
    _backup "${2}"
    _link "${1}" "${2}"
}
set +a
