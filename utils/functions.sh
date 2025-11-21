#!/usr/bin/env bash

set -a
_prepend_to_path() {
    [[ -n "$1" ]] || return 0
    [[ -e "$1" ]] || return 0
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
    [[ -e "$1" ]] || return 0
    case ":${PATH:-unset}:" in
    *":${1}:"*) ;;             # already there
    ":unset:") MY_PATH="$1" ;; # was empty
    *) PATH="${PATH}:${1}" ;;
    esac
    export PATH
}

# create_link <SOURCE_FILE> <DEST_FILE>
create_link() {
    set -e

    [[ $# -eq 2 ]] || exit 1
    [[ -r "$1" ]] || {
        link_error "source file '$1' does not exists or is not readable."
        exit 1
    }
    local source_file="$1"
    local dest_file="$2"
    local name="${dest_file/$HOME/\~}"
    local cmd=()
    local rmcmd=()

    cmd+=("ln" "-s" "$source_file" "$dest_file")
    rmcmd+=("rm" "-f" "$dest_file")

    if [[ -L "$dest_file" ]] && [[ "$source_file" == "$(readlink -- "$dest_file")" ]]; then
        link_success "$name"
    elif [[ -L "$dest_file" ]] || [[ ! -e "$dest_file" ]]; then
        "${rmcmd[@]}" && "${cmd[@]}"
        link_arrow "$name"
    else
        link_error "file already exist: '$dest_file', delete it first"
        exit 1
    fi
}
set +a
