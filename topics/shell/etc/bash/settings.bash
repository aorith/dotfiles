# vim: ft=bash

shopt -s checkwinsize
shopt -s histappend
shopt -s cmdhist # Save multi-line commands as one command

complete -cf sudo
bind 'set enable-bracketed-paste on'

if ((BASH_VERSINFO[0] >= 5)); then
    # History
    # Enable history expansion with space
    # E.g. typing !!<space> will replace the !! with your last command
    bind Space:magic-space

    shopt -s globstar 2> /dev/null # (enables ** to recurse all directories)
    shopt -s autocd 2> /dev/null # Prepend cd to directory names automatically
fi

export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/.bash_history"
export HISTCONTROL="erasedups:ignoreboth"
export HISTSIZE=50000
export HISTTIMEFORMAT="$(echo -e '\033[0;34m%h/%d %H:%M:%S\033[0m ')"
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Prompt
export PROMPT_DIRTRIM=2

