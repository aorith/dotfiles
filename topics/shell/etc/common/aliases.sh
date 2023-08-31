#!/bin/sh

alias fbox="distrobox enter fbox"
alias archbox="distrobox enter archbox"

alias ls='ls --color=auto'
alias diff='diff --color=auto'
alias htop='TERM=xterm-256color htop'
alias grep='grep --color=auto'

alias cd..='cd ..'
alias ..='cd ..'

alias nmap_scan='sudo nmap -sC -sV'
alias nmap_scan_ports='sudo nmap -p 1-65535'

alias syncthing-check-conflicts='fd ".*\.sync-conflict-.*" "$HOME/Syncthing/"'
alias repos_fzf='cd "$(fd \.git$ "$HOME/Syncthing/TES/gitlab" --max-depth 4 --type d --unrestricted --color never | fzf --delimiter / --with-nth -3,-4)/.."'
alias nixconf="cd ~/githome/nixconf"
alias private_dotfiles='cd $PRIVATE_DOTFILES'
alias private_githome='cd $PRIVATE_GITHOME'
alias k="kubectl"
alias rpm-ostree-changelogs='rpm-ostree db diff --changelogs'
