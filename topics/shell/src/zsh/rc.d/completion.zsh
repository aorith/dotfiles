# Zstyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

setopt NO_NOMATCH # avoid the 'zsh: no matches found...'

# Define completers
zstyle ':completion:*' completer _extensions _complete

zstyle ':completion:*'                     use-cache            true
zstyle ':completion:*'                     cache-path           ~/.cache/zsh_completion
zstyle ':completion:*'                     menu                 select
zstyle ':completion:*:default'             list-colors          ${(s.:.)LS_COLORS}
zstyle ':completion:*'                     list-dirs-first      true
zstyle ':completion:*'                     verbose              true
zstyle ':completion:*:manuals'             separate-sections    true
zstyle ':completion:*'                     special-dirs         true                                  # allow completion for ../
zstyle ':completion:*'                     squeeze-slashes      true                                  # squeeze double // instead of completing /*/
zstyle ':completion:*'                     group-name           ''                                    # group descriptions together
zstyle ':completion:*:*:*:*:descriptions'  format               ' %F{green}-- %d --%f'                # show completion descriptions
zstyle ':completion:*:*:*:*:corrections'   format               ' %F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:messages'            format               ' %F{purple} -- %d --%f'
zstyle ':completion:*:warnings'            format               ' %F{red}-- no matches found --%f'

# Make sure complist is loaded
zmodload zsh/complist

if [[ -n "$HOMEBREW_PREFIX" ]]; then
    FPATH=${HOMEBREW_PREFIX}/share/zsh-completions:$FPATH
    FPATH=${HOMEBREW_PREFIX}/share/zsh/site-functions:$FPATH
fi

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
