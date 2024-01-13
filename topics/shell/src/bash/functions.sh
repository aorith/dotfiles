#!/usr/bin/env bash

dotfiles() {
    if [[ -n "$1" ]]; then
        cd ~/githome/dotfiles/topics/"$1" || return 1
    else
        cd ~/githome/dotfiles || return 1
    fi
}

repos() {
    local gitdir _repo basepath
    basepath="${HOME}/Syncthing/TES/gitlab"
    [[ -n "$1" ]] || {
        echo "Changing dir to ${basepath}"
        cd "${basepath}" || return 1
        return 0
    }

    while read -r -d '' gitdir; do
        _repo=$(dirname -- "$gitdir")
        if basename -- "$_repo" | grep -Eq "^${1}$"; then
            echo "Found '$1' ... changing directory to '$_repo'."
            cd "$_repo" || {
                echo "ERROR: Could not change directory."
                return 1
            }
            return 0
        fi
    done < <(find "${basepath}" -maxdepth 4 -type d -name '.git' -print0)

    echo "ERROR: Unable to find repository: '$1'."
    return 1
}

repos-fzf() {
    local path
    path=$(fd \.git$ "$HOME/Syncthing/TES/gitlab" --max-depth 4 --type d --unrestricted --color never | fzf --delimiter / --with-nth -3,-4)
    if [[ -d "$path" ]]; then
        cd "${path}/.." || return 1
    fi
}

k8s-load-kubeconfig() {
    [[ -n "$PRIVATE_DOTFILES" ]] || {
        echo 'Environment variable "PRIVATE_DOTFILES" not set.'
        exit 1
    }
    opt=$(find "$PRIVATE_DOTFILES/k8s-configs/" -type f | awk -F'/' '{print $NF}' | fzf)
    [[ -f "$PRIVATE_DOTFILES/k8s-configs/$opt" ]] || {
        echo 'Kubeconfig not selected, aborting.'
        exit 1
    }
    export KUBECONFIG="$PRIVATE_DOTFILES/k8s-configs/$opt"
    echo "Loaded: $KUBECONFIG"
    kubectl cluster-info
}
