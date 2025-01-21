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
    p="$(
        fd \.git$ "${HOME}/githome/SyncRepos/${1:-DEXTools}" --max-depth 6 --type d --unrestricted --color never |
            fzf --reverse --border --margin 15% --delimiter / --with-nth -4,-3 --nth 2
    )"
    [[ -d "$p" ]] || return 1
    cd "${p}/.." || return 1
}

repos-old() {
    repos "TES"
}

,cd() {
    local p
    p="$(
        fd . "${1:-.}" --exclude .git --max-depth 6 --type d --unrestricted --color never |
            fzf --reverse --border --margin 15% --delimiter /
    )"
    [[ -d "$p" ]] || return 1
    cd "${p}" || return 1
}

# To manage k8s contexts, source the ,kc function here
# shellcheck disable=SC1091
source "${PRIVATE_DOTFILES}/topics/k8s/k8s-kc"

# To manage aws profiles, source the ,aws function here
# shellcheck disable=SC1091
source "${PRIVATE_DOTFILES}/topics/aws/,aws"
