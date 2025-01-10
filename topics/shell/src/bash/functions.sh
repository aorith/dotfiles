#!/usr/bin/env bash

dotfiles() {
    if [[ -n "$1" ]]; then
        cd ~/githome/dotfiles/topics/"$1" || return 1
    else
        cd ~/githome/dotfiles || return 1
    fi
}

repos() {
    local p
    p="$(fd \.git$ "${HOME}/storage/tank/data/TES/gitlab" --max-depth 4 --type d --unrestricted --color never | fzf --delimiter / --with-nth -3,-4)"
    [[ -d "$p" ]] || return
    cd "${p}/.." || return 1
}

# To manage k8s contexts, source the ,kc function here
# shellcheck disable=SC1091
source "${PRIVATE_DOTFILES}/topics/k8s/k8s-kc"
