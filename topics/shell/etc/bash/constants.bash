# vim: ft=bash
# Sourced from: profile

export EDITOR='nvim'
export VISUAL=$EDITOR
export TERMINAL='alacritty'

#export LESS='-RM' # F option breaks i3 "show errors"
export LESSHISTFILE="$HOME/.local/state/lesshst"
export PAGER='less'
export MANPAGER="$PAGER"
#export SYSTEMD_LESS="$LESS"

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
if command -v fd >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --type f --follow --exclude .git'
fi

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

    if [[ -f /private/etc/manpaths ]]; then
        while read -r man_path; do
            add_to_manpath "$man_path"
        done </private/etc/manpaths
    fi
    unset manpath oldIFS
elif [[ "$_OS" == 'Linux' ]]; then
    # Linux only
    if [[ -n "$WAYLAND_DISPLAY" ]] || [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
        export CLIPBOARD_COPY="wl-copy"
        export CLIPBOARD_PASTE="wl-paste"
        alias pbcopy='wl-copy'
    else
        export CLIPBOARD_COPY="xclip -i -selection primary -f | xclip -i -selection clipboard"
        export CLIPBOARD_PASTE="xclip -out -selection clipboard"
    fi
    export SUBL_CMD='subl'
    export EXEC_DATE='date'
    export INPUTRC="${HOME}/.inputrc"
    export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=lcd'
fi
