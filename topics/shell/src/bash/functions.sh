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
        fd \.git$ "${HOME}/githome/SyncRepos/DEXTools" --max-depth 4 --type d --unrestricted --color never |
            fzf --reverse --border --margin 15% --delimiter / --with-nth -4,-3 --nth 2
    )"
    [[ -d "$p" ]] || return
    cd "${p}/.." || return 1
}

# To manage k8s contexts, source the ,kc function here
# shellcheck disable=SC1091
source "${PRIVATE_DOTFILES}/topics/k8s/k8s-kc"

# To manage aws profiles, source the ,aws function here
# shellcheck disable=SC1091
source "${PRIVATE_DOTFILES}/topics/aws/,aws"
