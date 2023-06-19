# ~/.zshrc

HISTFILE=~/.local/share/zsh/history
HISTSIZE=10000
SAVEHIST=10000
alias history='history -t "[%F %T]"' # show time

setopt AUTOCD
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt SHARE_HISTORY
setopt HIST_IGNORE_SPACE
setopt HIST_VERIFY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt INC_APPEND_HISTORY_TIME
setopt COMPLETE_ALIASES

setopt CLOBBER # allow > redirection to truncate existing files
setopt NO_BEEP # do not beep on errors
setopt INTERACTIVE_COMMENTS # allow use of comments in interactive code
setopt AUTO_PARAM_SLASH # complete folders with / at end
setopt LIST_TYPES # mark type of completion suggestions
setopt LONG_LIST_JOBS # display PID when suspending processes as well
setopt NOTIFY # report status of background jobs immediately
unsetopt RM_STAR_SILENT # notify when rm is running with *
setopt RM_STAR_WAIT # wait for 10 seconds confirmation when running rm with *

# Shared aliases and variables
emulate sh -c 'source ~/githome/dotfiles/topics/shell/etc/common/exports.sh'
emulate sh -c 'source ~/githome/dotfiles/topics/shell/etc/common/aliases.sh'

# Emacs style bindings
bindkey -e
# Fix delete key
bindkey "^[[3~" delete-char
# Use incremental search
bindkey "^R" history-incremental-search-backward

# Colors. Example: `echo $bg[red] hello`
autoload -Uz colors
colors

# Completion
source $ZDOTDIR/rc.d/completion.zsh

# Prompt
source $ZDOTDIR/rc.d/prompt.zsh

# Extra
if [[ -e "$PRIVATE_DOTFILES" ]]; then
    emulate sh -c 'source "$PRIVATE_DOTFILES/topics/tcdn/env/all/bash/04_aliases"'
fi

# Plugins, keep this at the end
source $ZDOTDIR/rc.d/plugins.zsh

# Force path arrays to have unique values only
typeset -gU path cdpath fpath manpath
