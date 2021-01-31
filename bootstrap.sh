#!/usr/bin/env bash

shopt -s nullglob

. ./topics/shell/src/profile
cd "$DOTFILES" || exit 1
. ./utils/functions.sh
. ./utils/messages.sh

log_header "Start"

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
        if test -x topics/$1/postinstall.sh; then
            log_info "Postinstall for topic: $1"
            pushd "topics/$1" >/dev/null || exit 1
            if ! ./postinstall.sh; then
                log_error "Execution of \"$1/postinstall.sh\" failed."
                popd >/dev/null || exit 1
                exit 1
            fi
            popd >/dev/null || exit 1
        fi

    }

    log_header "Bootstrapping $1 only."; echo
    bootstrap_topic $1
    if test -d "$PRIVATE_DOTFILES"; then
        cd "$PRIVATE_DOTFILES" || exit 1
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
unset init_script

if test -d "$PRIVATE_DOTFILES"; then
    log_header "Bootstrap of private dotfiles"
    cd "$PRIVATE_DOTFILES" || exit 1
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
    for postinstall_script in topics/*/postinstall.sh; do
        log_info "Postinstall for topic: $(basename $(dirname "${postinstall_script}"))"
        pushd "$(dirname "$postinstall_script")" >/dev/null || exit 1
        if ! ./postinstall.sh; then
            log_error "Execution of \"$postinstall_script\" failed."
            popd >/dev/null || exit 1
            exit 1
        fi
        popd >/dev/null || exit 1
    done
    unset postinstall_script
fi

cd "$DOTFILES" || exit 1
log_header "Postinstall scripts"
for postinstall_script in topics/*/postinstall.sh; do
    log_info "Postinstall for topic: $(basename $(dirname "${postinstall_script}"))"
    pushd "$(dirname "$postinstall_script")" >/dev/null || exit 1
    if ! ./postinstall.sh; then
        log_error "Execution of \"$postinstall_script\" failed."
        popd >/dev/null || exit 1
        exit 1
    fi
    popd >/dev/null || exit 1
done
unset postinstall_script

log_header "Updating git submodules"
git submodule sync
git submodule update --init --recursive

log_header "End"
