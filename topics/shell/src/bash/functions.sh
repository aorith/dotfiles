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
        fd \.git$ "${HOME}/githome" --max-depth 8 --type d --follow --unrestricted --color never |
            fzf --reverse --border --margin 15% --delimiter / --with-nth 5..-3
    )"
    [[ -d "$p" ]] || return 1
    cd "${p}/.." || return 1
}

,cd() {
    local p
    p="$(
        fd . "${1:-.}" --exclude .git --max-depth 10 --type d --follow --unrestricted --color never |
            fzf --reverse --border --margin 15% --delimiter /
    )"
    [[ -d "$p" ]] || return 1
    cd "${p}" || return 1
}

tt() {
    local todo="$HOME/Syncthing/SYNC_STUFF/notes/zk/todo/todo.txt"
    if [[ -n "$1" ]]; then
        grep "$1" "$todo" | sort | bat --plain --language todo.txt --theme ansi
    else
        sort "$todo" | bat --plain --language todo.txt --theme ansi "$todo"
    fi
}

te() {
    local todo="$HOME/Syncthing/SYNC_STUFF/notes/zk/todo/todo.txt"
    local _done="$HOME/Syncthing/SYNC_STUFF/notes/zk/todo/done.txt"
    "$EDITOR" -o "$todo" "$_done"
}

# To manage k8s contexts, source the ,kc function here
# shellcheck disable=SC1091
if [[ -f "$HOME/githome/dotfiles/topics/shell/etc/common/k8s-kc" ]]; then
    . "$HOME/githome/dotfiles/topics/shell/etc/common/k8s-kc"
fi
alias ,kc='kc'
alias ,kcn='kc n'

# To manage aws profiles, source the awsp function here
# shellcheck disable=SC1091
if [[ -f "$HOME/githome/dotfiles/topics/shell/etc/common/awsp" ]]; then
    . "$HOME/githome/dotfiles/topics/shell/etc/common/awsp"
fi
alias ,aws='awsp'
