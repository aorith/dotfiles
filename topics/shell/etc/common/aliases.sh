#!/usr/bin/env bash

alias ls='ls --color=auto'
alias ll='ls -Ahl --group-directories-first --color=auto'
alias diff='diff --color=auto'
alias htop='TERM=xterm-256color htop'
alias grep='grep --color=auto'
alias ssh='env TERM=xterm-256color ssh'

alias cd..='cd ..'
alias ..='cd ..'

alias nmap_scan='sudo nmap -sC -sV'
alias nmap_scan_ports='sudo nmap -p 1-65535'

alias syncthing-check-conflicts='fd --unrestricted --regex -L ".*\.sync-conflict-.*" ~/Syncthing/'
alias nixconf="cd ~/githome/nixconf"
alias private_dotfiles='cd "$PRIVATE_DOTFILES"'
alias private_githome='cd "$PRIVATE_GITHOME"'
alias k="kubectl"
alias rpm-ostree-changelogs='rpm-ostree db diff --changelogs'

# Wrap some self-contained nix pkgs like my neovim-flake inside of distrobox container
# by adding them to PATH (/nix/store is already mounted).
# When EXTRA_PATH variable exists it's appended to PATH, see topics/shell/etc/common/env.sh
wrap_nix_distrobox() {
    local extra_path
    [[ -z "$CONTAINER_ID" ]] || {
        echo "Already inside of the container '$CONTAINER_ID'."
        exit 1
    }
    _get_path() {
        dirname -- "$(realpath -- "$(which "$1")")"
    }
    extra_path="$(_get_path nvim):$(_get_path nix)"
    # shellcheck disable=SC2016
    distrobox enter --additional-flags "--env EXTRA_PATH=$extra_path" "$1"
}

alias fbox="wrap_nix_distrobox fbox"
alias archbox="wrap_nix_distrobox archbox"
alias tbox="wrap_nix_distrobox tumbleweed"
