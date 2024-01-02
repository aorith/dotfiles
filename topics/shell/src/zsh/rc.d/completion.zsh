# Zstyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

setopt NO_NOMATCH # avoid the 'zsh: no matches found...'

# Define completers
#zstyle ':completion:*' completer _extensions _complete

zstyle ':completion:*'                     use-cache            true
zstyle ':completion:*'                     cache-path           ~/.cache/zsh_completion
zstyle ':completion:*'                     menu                 select
zstyle ':completion:*:default'             list-colors          ${(s.:.)LS_COLORS}
zstyle ':completion:*'                     list-dirs-first      true
#zstyle ':completion:*'                     verbose              true
zstyle ':completion:*:manuals'             separate-sections    true
zstyle ':completion:*'                     special-dirs         true                                  # allow completion for ../
zstyle ':completion:*'                     squeeze-slashes      true                                  # squeeze double // instead of completing /*/

# Make sure complist is loaded
zmodload zsh/complist

fpath=(/usr/share/zsh/site-functions $fpath)
if [[ -n "$HOMEBREW_PREFIX" ]]; then
    fpath=(${HOMEBREW_PREFIX}/share/zsh-completions $fpath)
    fpath=(${HOMEBREW_PREFIX}/share/zsh/site-functions $fpath)
fi

# FZF
if [[ -e /usr/share/zsh/site-functions/fzf ]]; then
    source /usr/share/zsh/site-functions/fzf # fedora
    source /usr/share/fzf/shell/key-bindings.zsh
elif [[ -e /usr/share/fzf/completion.zsh ]]; then
    source /usr/share/fzf/completion.zsh
    source /usr/share/fzf/key-bindings.zsh
fi

# Pass (password store): https://github.com/junegunn/fzf/wiki/Examples-(completion)#zsh-pass
# TODO: figure out why this is not working
_fzf_complete_pass() {
  _fzf_complete +m -- "$@" < <(
    local prefix
    prefix="${PASSWORD_STORE_DIR:-$HOME/.password-store}"
    command find -L "$prefix" \
      -name "*.gpg" -type f | \
      sed -e "s#${prefix}/\{0,1\}##" -e 's#\.gpg##' -e 's#\\#\\\\#' | sort
  )
}

# Init completions, but regenerate compdump only once a day.
# The globbing is a little complicated here:
# - '#q' is an explicit glob qualifier that makes globbing work within zsh's [[ ]] construct.
# - 'N' makes the glob pattern evaluate to nothing when it doesn't match (rather than throw a globbing error)
# - '.' matches "regular files"
# - 'mh+20' matches files (or directories or whatever) that are older than 20 hours.
autoload -Uz compinit
if [[ -n ${XDG_CACHE_HOME}/zsh/compdump(#qN.mh+20) ]]; then
    compinit -i -u -d ${XDG_CACHE_HOME}/zsh/compdump
    # zrecompile fresh compdump in background
    {
        autoload -Uz zrecompile
        zrecompile -pq ${XDG_CACHE_HOME}/zsh/compdump
    } &!
else
    compinit -i -u -C -d ${XDG_CACHE_HOME}/zsh/compdump
fi

# Enable bash completions too
autoload -Uz bashcompinit && bashcompinit

# External completions
source <(kubectl completion zsh)
