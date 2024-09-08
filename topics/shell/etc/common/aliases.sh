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

alias fbox="~/githome/dotfiles/topics/distrobox/db-wrapper fbox"
alias fbox-slim="~/githome/dotfiles/topics/distrobox/db-wrapper fbox-slim"
alias archbox="~/githome/dotfiles/topics/distrobox/db-wrapper archbox"
alias tbox="~/githome/dotfiles/topics/distrobox/db-wrapper tbox"
alias ubox="~/githome/dotfiles/topics/distrobox/db-wrapper ubox"
