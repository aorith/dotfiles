#!/usr/bin/env bash

set -a
_prepend_to_path() {
    [[ -n "$1" ]] || return 0
    [[ -e "$1" ]] || return 0
    case ":${MY_PATH-}:" in
    *":${1}:"*) ;; # already there
    *) MY_PATH="${1}${MY_PATH:+:$MY_PATH}" ;;
    esac
}

# Prepends MY_PATH and keeps only the first occurrence of each entry
_prepend_to_path_commit() {
    local p out=":"
    local -a parts
    IFS=: read -ra parts <<<"${MY_PATH:+$MY_PATH:}$PATH"
    for p in "${parts[@]}"; do
        if [[ -n "$p" && "$out" != *":${p}:"* ]]; then
            out+="${p}:"
        fi
    done
    out="${out#:}"
    export PATH="${out%:}"
    unset MY_PATH
}

# create_link <SOURCE_FILE> <DEST_FILE>
create_link() {
    set -e

    [[ $# -eq 2 ]] || exit 1
    [[ -r "$1" ]] || {
        link_error "source file '$1' does not exist or is not readable."
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
        link_error "file already exists: '$dest_file', delete it first"
        exit 1
    fi
}
set +a
