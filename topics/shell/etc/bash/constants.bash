# vim: ft=bash
# Sourced from: profile

export EDITOR='vim'
export VISUAL=$EDITOR
export TERMINAL='alacritty'
export MY_NOTES_DIR="${HOME}/Syncthing/SYNC_STUFF/Notes"
export MY_WIKI_DIR="${MY_NOTES_DIR}/Wiki"

export LESS='-RM' # F option breaks i3 "show errors"
export LESSHISTFILE='-'
export PAGER='less'
export MANPAGER="$PAGER"
#export SYSTEMD_LESS="$LESS"

if [[ -x "/usr/bin/lesspipe" ]]; then
    eval $(/usr/bin/lesspipe)
elif [[ -r "/usr/local/bin/lesspipe.sh" ]]; then
    export LESSOPEN="|/usr/local/bin/lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1
fi

export LESS_TERMCAP_mb=$'\033[01;31m'               # begins blinking
export LESS_TERMCAP_md=$'\033[01;31m'               # begins bold (headers, titles ...)
export LESS_TERMCAP_me=$'\033[0m'                   # ends mode
export LESS_TERMCAP_se=$'\033[0m'                   # ends standout-mode
export LESS_TERMCAP_ue=$'\033[0m'                   # ends underline
export LESS_TERMCAP_so=$'\033[01;44;37m'            # begins standout-mode (highligh and statusbar)
export LESS_TERMCAP_us=$'\033[01;32m'               # begins underline (key words)

man() {
    env LESS_TERMCAP_us=$'\033[31m' \
        LESS_TERMCAP_md=$'\033[1;33m' \
        man "$@"
}

export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.local/cache"
export XDG_BIN_HOME="${HOME}/.local/bin"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export GOPATH="${HOME}/.local/go:${PRIVATE_GITHOME}/go"
export GOBIN="${HOME}/.local/go/bin"
[[ ! -d "${GOBIN}" ]] || add_to_path "${GOBIN}"
[[ ! -d "$HOME/.cargo/bin" ]] || add_to_path "$HOME/.cargo/bin"
add_to_path "$HOME/.local/bin"

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# FZF
export FZF_DEFAULT_COMMAND='fd --type f --follow --exclude .git'
export FZF_DEFAULT_OPTS='--layout=reverse --info=inline'

# OS specific
if [[ "$_OS" == 'Darwin' ]]; then
    # Macos only
    export CLIPBOARD_COPY="pbcopy"
    export CLIPBOARD_PASTE="pbpaste"
    export SUBL_CMD='/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl'
    export EXEC_DATE='gdate'

    if type manpath >/dev/null 2>&1; then
        oldIFS="$IFS"
        IFS=:
        for man_path in $(manpath); do
            add_to_manpath "$man_path"
        done
        IFS="$oldIFS"
        unset man_path
    fi

    for man_path in $(cat /private/etc/manpaths); do
        add_to_manpath "$man_path"
    done 2>/dev/null
    unset manpath oldIFS
elif [[ "$_OS" == 'Linux' ]]; then
    # Linux only
    export CLIPBOARD_COPY="xclip -i -selection primary -f | xclip -i -selection clipboard"
    export CLIPBOARD_PASTE="xclip -out -selection clipboard"
    export SUBL_CMD='subl'
    export EXEC_DATE='date'
    export INPUTRC="${HOME}/.inputrc"
    export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
fi
