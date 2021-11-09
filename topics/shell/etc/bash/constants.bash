# vim: ft=bash
# Sourced from: profile

export EDITOR='vim'
export VISUAL=$EDITOR
export TERMINAL='alacritty'

# Znotes
export ZNOTES_ZET_DIR="$HOME/Syncthing/SYNC_STUFF/Notes/Zettelkasten/"
export ZNOTES_TODO_DIR="$HOME/Syncthing/SYNC_STUFF/Notes/TODO/"
export ZNOTES_TODO_DONE_DIR="$HOME/Syncthing/SYNC_STUFF/Notes/.TODO_DONE/"

#export LESS='-XRMie' # F option breaks i3 "show errors"
export LESSHISTFILE='-'
export PAGER='less'
export MANPAGER="$PAGER"
#export SYSTEMD_LESS="$LESS"

if [[ -x "/usr/bin/lesspipe" ]]; then
    eval $(/usr/bin/lesspipe)
elif [[ -r "/usr/local/bin/lesspipe.sh" ]]; then
    export LESSOPEN="|/usr/local/bin/lesspipe.sh %s" LESS_ADVANCED_PREPROCESSOR=1
fi

#export LESS_TERMCAP_mb=$'\033[01;31m'            # begins blinking
#export LESS_TERMCAP_md=$(tput setaf 4; tput bold) # begins bold (headers, titles ...)
export LESS_TERMCAP_me=$'\033[0m'                # ends mode
export LESS_TERMCAP_so=$(tput rev)                # begins standout-mode (highligh and statusbar)
export LESS_TERMCAP_se=$'\033[0m'                # ends standout-mode
#export LESS_TERMCAP_us=$(tput setaf 1)            # begins underline (key words)
export LESS_TERMCAP_ue=$'\033[0m'                # ends underline

man() {
    env LESS_TERMCAP_us=$(tput setaf 1) \
        LESS_TERMCAP_md=$(tput setaf 4; tput bold) \
        man "$@"
}

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export WGETRC="${XDG_CONFIG_HOME:-$HOME/.config}/wget/wgetrc"
export GOPATH="${HOME}/go:${PRIVATE_GITHOME}/go"
export GOBIN="${HOME}/go/bin"
[[ ! -d "${GOBIN}" ]] || add_to_path "${GOBIN}"
[[ ! -d "${HOME}/.local/bin" ]] || add_to_path "${HOME}/.local/bin"

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
    unset manpath
elif [[ "$_OS" == 'Linux' ]]; then
    # Linux only
    export CLIPBOARD_COPY="xclip -i -selection clipboard"
    export CLIPBOARD_PASTE="xclip -out -selection clipboard"
    export SUBL_CMD='subl'
    export EXEC_DATE='date'

    export BROWSER='firefox'
    export READER='zathura'
    export INPUTRC="${HOME}/.inputrc"
    export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
fi

