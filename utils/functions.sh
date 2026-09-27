#!/usr/bin/env bash

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
