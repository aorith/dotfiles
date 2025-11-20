#!/usr/bin/env bash

alias ls='ls --hyperlink=auto --color=auto'
alias ll='ls --hyperlink=auto -Ahl --group-directories-first --color=auto'
alias diff='diff --color=auto'
alias htop='TERM=xterm-256color htop'
alias grep='grep --color=auto'
alias ssh='TERM=xterm-256color ssh'
alias delta="delta --hyperlinks --hyperlinks-file-link-format='file://{path}#{line}'"
alias rg='rg --hyperlink-format=kitty'

alias cd..='cd ..'
alias ..='cd ..'

alias wget='wget --hsts-file=~/.local/state/.wget-hsts'
alias nmap_scan='sudo nmap -sC -sV'
alias nmap_scan_ports='sudo nmap -p 1-65535'

alias syncthing-check-conflicts='fd --unrestricted --regex -L ".*\.sync-conflict-.*" ~/Syncthing/'
alias nixconf="cd ~/githome/nixconf"
alias private_dotfiles='cd "$PRIVATE_DOTFILES"'
alias private_githome='cd "$PRIVATE_GITHOME"'
if command -v kubecolor >/dev/null 2>&1; then
    alias k="kubecolor"
else
    alias k="kubectl"
fi
