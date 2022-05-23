#!/usr/bin/env bash

shopt -s nullglob

cd "$(dirname "$0")" || exit 1
. ./topics/shell/src/bash/profile
cd "$DOTFILES" || exit 1
. ./utils/functions.sh
. ./utils/messages.sh
export _SKIP=247 # valid exit codes: 0-255

# check for basic commands
deps="awk curl wget bc fzf find sed git bat glow"
for dep in $deps; do
    command -v "$dep" &>/dev/null || { printf '%s not found.\n' "$dep"; exit 1; }
done

check_result() {
    [[ $1 -ne $_SKIP ]] || { log_skip "$2"; return 0; }
    log_error "Execution of \"$3\" failed."
    popd >/dev/null || exit 1
    exit 1
}

_bootstrap() {
    local _topic_glob
    _topic_glob="${4:-*}"

    log_header "$3"
    for folder in $1; do
        [[ -d "$folder" ]] || { log_skip "$folder"; continue; }
        pushd "$folder" >/dev/null || exit 1

        # Check if topic exists, compgen -G returns 1 if no matches
        if ! compgen -G "topics/${_topic_glob}" &>/dev/null; then
            log_info "No topic matching \"${_topic_glob}\" in \"$folder/topics\""
            popd >/dev/null || exit 1
            continue
        fi

        for script in topics/${_topic_glob}/${2}; do
            if [[ -x "$script" ]]; then
                topic="$(basename "$(dirname "$script")")"
                log_topic "$topic"
                pushd "$(dirname "$script")" >/dev/null || exit 1
                "./${2}" || check_result $? "$topic" "$script"
                popd >/dev/null || exit 1
            else
                [[ ! -f "$script" ]] || log_skip "$script (no exec permissions)"
            fi
        done
        popd >/dev/null || exit 1
    done
    unset folder topic script
}

log_header "Start"

if [[ $# -eq 1 ]]; then
    # Bootstrap only topics that match the glob in $1
    _bootstrap "$DOTFILES"          "install.sh"     "Install requirements"            "$1"
    _bootstrap "$DOTFILES"          "init.sh"        "Bootstrap of dotfiles"           "$1"
    _bootstrap "$PRIVATE_DOTFILES"  "install.sh"     "Install requirements (private)"  "$1"
    _bootstrap "$PRIVATE_DOTFILES"  "init.sh"        "Bootstrap of dotfiles (private)" "$1"
    _bootstrap "$DOTFILES"          "postinstall.sh" "Postinstall"                     "$1"
    _bootstrap "$PRIVATE_DOTFILES"  "postinstall.sh" "Postinstall (private)"           "$1"
    exit 0
else
    # Bootstrap all topics
    _bootstrap "$DOTFILES"          "install.sh"     "Install requirements"            "*"
    _bootstrap "$DOTFILES"          "init.sh"        "Bootstrap of dotfiles"           "*"
    _bootstrap "$PRIVATE_DOTFILES"  "install.sh"     "Install requirements (private)"  "*"
    _bootstrap "$PRIVATE_DOTFILES"  "init.sh"        "Bootstrap of dotfiles (private)" "*"
    _bootstrap "$DOTFILES"          "postinstall.sh" "Postinstall"                     "*"
    _bootstrap "$PRIVATE_DOTFILES"  "postinstall.sh" "Postinstall (private)"           "*"
fi

log_header "End"
