#!/usr/bin/env bash

shopt -s nullglob

cd "$(dirname "$0")" || exit 1
. ./topics/shell/src/bash/profile
cd "$DOTFILES" || exit 1
. ./utils/functions.sh
. ./utils/messages.sh
export _SKIP=247 # valid exit codes: 0-255

check_result() {
    [[ $1 -ne $_SKIP ]] || { log_skip "$2"; return 0; }
    log_error "Execution of \"$3\" failed."
    popd >/dev/null || exit 1
    exit 1
}

_bootstrap() {
    local folders folder _script title topic _topic_glob
    folders="$1"
    _script="$2"
    title="$3"
    _topic_glob="${4:-*}"
    log_header "$title"
    for folder in $folders; do
        [[ -d "$folder" ]] || { log_skip "$folder"; continue; }
        pushd "$folder" >/dev/null || exit 1
        # Check if topic exists
        if [[ $(ls topics/${_topic_glob}/ 2>/dev/null | wc -l) -eq 0 ]]; then
            log_info "No topic matching \"${_topic_glob}\" in \"$folder/topics\""
            popd >/dev/null || exit 1
            continue
        fi
        for script in topics/${_topic_glob}/${_script}; do
            if [[ -f "${script}" ]]; then
                topic="$(basename $(dirname "${script}"))"
                log_topic "${topic}"
                pushd "$(dirname "$script")" >/dev/null || exit 1
                "./${_script}" || check_result $? "$topic" "$script"
                popd >/dev/null || exit 1
            fi
        done
        popd >/dev/null || exit 1
    done
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

log_header "Updating git submodules"
git submodule sync
git submodule update --init --recursive

case $HOSTNAME in
    admin-*) ;;
    *) sed -i 's,url = https://github.com/aorith/dotfiles,url = git@github.com:aorith/dotfiles.git,g' "${DOTFILES}/.git/config" ;;
esac

log_header "End"
