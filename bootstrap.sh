#!/usr/bin/env bash

shopt -s nullglob

PRIV_DOTFILES="$HOME/Syncthing/SYNC_STUFF/private_dotfiles"
DOTFILES="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ENV_FILES_FOLDER="$HOME/.config/env_files_folder"
cd "$DOTFILES" || exit 1
. ./utils/functions.sh
. ./utils/messages.sh

log_header "Start"

# Create ENV_FILES_FOLDER
[[ ! -d "$ENV_FILES_FOLDER" ]] && mkdir -p "$ENV_FILES_FOLDER"

# Boostrap only one topic
if [[ $# -gt 0 ]]; then

    bootstrap_topic() {
        ! test -d "topics/$1" && return

        if test -x topics/$1/install.sh; then
            log_info "Installing topic: $1"
            pushd "topics/$1" >/dev/null || exit 1
            if ! ./install.sh; then
                log_error "Execution of \"$1/install.sh\" failed."
                popd >/dev/null || exit 1
                exit 1
            fi
            popd >/dev/null || exit 1
        fi
        if test -x topics/$1/init.sh; then
            log_info "Working on topic: $1"
            pushd "topics/$1" >/dev/null || exit 1
            if ! ./init.sh; then
                log_error "Execution of \"$1/init.sh\" failed."
                popd >/dev/null || exit 1
                exit 1
            fi
            popd >/dev/null || exit 1
        fi

    }
    
    log_header "Bootstrapping $1 only."; echo
    bootstrap_topic $1
    if test -d "$PRIV_DOTFILES"; then
        cd "$PRIV_DOTFILES" || exit 1
        bootstrap_topic $1
    fi
    log_header "End"
    cd "$DOTFILES" || exit 1
    exit 0
fi

log_header "Install requirements"
for install_script in topics/*/install.sh; do
    log_info "Installing topic: $(basename $(dirname "${install_script}"))"
    pushd "$(dirname "$install_script")" >/dev/null || exit 1
    if ! ./install.sh; then
        log_error "Execution of \"$install_script\" failed."
        popd >/dev/null || exit 1
        exit 1
    fi
    popd >/dev/null || exit 1
done
unset install_script

log_header "Bootstrap of dotfiles"
for init_script in topics/*/init.sh; do
    log_info "Working on topic: $(basename $(dirname "${init_script}"))"
    pushd "$(dirname "$init_script")" >/dev/null || exit 1
    if ! ./init.sh; then
        log_error "Execution of \"$init_script\" failed."
        popd >/dev/null || exit 1
        exit 1
    fi
    popd >/dev/null || exit 1
done

if test -d "$PRIV_DOTFILES"; then
    log_header "Bootstrap of private dotfiles"
    cd "$PRIV_DOTFILES" || exit 1
    for install_script in topics/*/install.sh; do
        log_info "Installing topic: $(basename $(dirname "${install_script}"))"
        pushd "$(dirname "$install_script")" >/dev/null || exit 1
        if ! ./install.sh; then
            log_error "Execution of \"$install_script\" failed."
            popd >/dev/null || exit 1
            exit 1
        fi
        popd >/dev/null || exit 1
    done
    unset install_script
    for init_script in topics/*/init.sh; do
        log_info "Working on topic: $(basename $(dirname "${init_script}"))"
        pushd "$(dirname "$init_script")" >/dev/null || exit 1
        if ! ./init.sh; then
            log_error "Execution of \"$init_script\" failed."
            popd >/dev/null || exit 1
            exit 1
        fi
        popd >/dev/null || exit 1
    done
    unset init_script
fi

cd "$DOTFILES" || exit 1

log_header "Updating git submodules"
git submodule update --remote --jobs=4

log_header "End"
