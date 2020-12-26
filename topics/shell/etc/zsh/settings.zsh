# vim: ft=zsh

autoload -Uz add-zsh-hook
autoload -Uz compinit && compinit -i
zstyle ':completion:*' menu select
zmodload zsh/complist
autoload bashcompinit
bashcompinit

HISTSIZE=1048576
HISTFILE="$HOME/.local/share/.zsh_history"
SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY
setopt APPEND_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS

# Use incremental search
bindkey "^R" history-incremental-search-backward

# Enable interactive comments (# on the command line)
setopt INTERACTIVE_COMMENTS

# Complate aliases
setopt COMPLETE_ALIASES
