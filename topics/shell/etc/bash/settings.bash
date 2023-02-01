# vim: ft=bash
# Sourced from: bash_profile

complete -cf sudo

shopt -s checkwinsize histappend cmdhist globstar autocd 2>/dev/null
set -o notify # notify completed background jobs inmediately

export HISTFILE="${XDG_DATA_HOME:-$HOME/.local/share}/.bash_history"
export HISTCONTROL="erasedups:ignoreboth"
export HISTSIZE=10000
export HISTTIMEFORMAT="$(echo -e '\033[0;34m%h/%d %H:%M:%S\033[0m ')"
export HISTIGNORE="&:[ ]*:exit:ls:bg:fg:history:clear"

# Prompt
export PROMPT_DIRTRIM=3
export PS4='+ ${BASH_SOURCE:-}:${LINENO:-}: ${FUNCNAME[0]:-}() [${?:-}] → '
