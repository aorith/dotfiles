#!/usr/bin/env bash
# shellcheck disable=SC1090,SC2155,SC1091

export GITHOME="$HOME/githome"
export DOTFILES="$GITHOME/dotfiles"
export PRIVATE_GITHOME="$HOME/Syncthing/SYNC_STUFF/githome"
export PRIVATE_DOTFILES="$PRIVATE_GITHOME/private_dotfiles"

if type -f nvim >/dev/null 2>&1; then
    export EDITOR="nvim"
else
    export EDITOR="vim"
fi

export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export PYTHONPYCACHEPREFIX="/tmp/python-cache" # fine for sinlge-user systems

# AA for java apps
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on"
_JAVA_OPTIONS="-Dswing.aatext=true"

# Some java apps won't display correctly without this
export _JAVA_AWT_WM_NONREPARENTING=1

export LESSHISTFILE="$XDG_DATA_HOME/less_history"
export IPYTHONDIR="$XDG_DATA_HOME/ipython"
export GOBIN="$HOME/.local/go/bin"
export GOPATH="$XDG_CACHE_HOME/golang"
export ANSIBLE_HOME="$XDG_DATA_HOME/ansible"
export XCOMPOSECACHE="$XDG_CACHE_HOME/X11/xcompose"

export FZF_DEFAULT_COMMAND="fd --type f --follow --exclude .git"

# See: https://wiki.archlinux.org/title/Color_output_in_console#man
export MANPAGER="less -R --use-color -Dd+r -Du+b"
export MANROFFOPT="-P -c"

export LS_COLORS="*.7z=01;31:*.aac=00;36:*.ace=01;31:*.alz=01;31:*.arc=01;31:*.arj=01;31:*.asf=01;35:*.au=00;36:*.avi=01;35:*.bmp=01;35:*.bz=01;31:*.bz2=01;31:*.cab=01;31:*.cgm=01;35:*.cpio=01;31:*.deb=01;31:*.dl=01;35:*.dwm=01;31:*.dz=01;31:*.ear=01;31:*.emf=01;35:*.esd=01;31:*.flac=00;36:*.flc=01;35:*.fli=01;35:*.flv=01;35:*.gif=01;35:*.gl=01;35:*.gz=01;31:*.jar=01;31:*.jpeg=01;35:*.jpg=01;35:*.lha=01;31:*.lrz=01;31:*.lz=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.lzo=01;31:*.m2v=01;35:*.m4a=00;36:*.m4v=01;35:*.mid=00;36:*.midi=00;36:*.mjpeg=01;35:*.mjpg=01;35:*.mka=00;36:*.mkv=01;35:*.mng=01;35:*.mov=01;35:*.mp3=00;36:*.mp4=01;35:*.mp4v=01;35:*.mpc=00;36:*.mpeg=01;35:*.mpg=01;35:*.nuv=01;35:*.oga=00;36:*.ogg=00;36:*.ogm=01;35:*.ogv=01;35:*.ogx=01;35:*.opus=00;36:*.pbm=01;35:*.pcx=01;35:*.pgm=01;35:*.png=01;35:*.ppm=01;35:*.qt=01;35:*.ra=00;36:*.rar=01;31:*.rm=01;35:*.rmvb=01;35:*.rpm=01;31:*.rz=01;31:*.sar=01;31:*.spx=00;36:*.svg=01;35:*.svgz=01;35:*.swm=01;31:*.t7z=01;31:*.tar=01;31:*.taz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tga=01;35:*.tgz=01;31:*.tif=01;35:*.tiff=01;35:*.tlz=01;31:*.txz=01;31:*.tz=01;31:*.tzo=01;31:*.tzst=01;31:*.vob=01;35:*.war=01;31:*.wav=00;36:*.webm=01;35:*.wim=01;31:*.wmv=01;35:*.xbm=01;35:*.xcf=01;35:*.xpm=01;35:*.xspf=00;36:*.xwd=01;35:*.xz=01;31:*.yuv=01;35:*.z=01;31:*.zip=01;31:*.zoo=01;31:*.zst=01;31:bd=40;33;01:ca=30;41:cd=40;33;01:di=01;34:do=01;35:ex=01;32:pi=40;33:ln=01;36:mi=00:mh=00:or=40;31;01:ow=34;42:rs=0:sg=30;43:su=37;41:so=01;35:st=37;44:tw=30;42:"

export CLIPBOARD_COPY="pbcopy"
export CLIPBOARD_PASTE="pbpaste"

# Source
. ~/githome/dotfiles/utils/functions.sh

# # Nix (non NixOS)
# if [[ ! -e /etc/nixos ]]; then
#     # Terraform >= 1.6.0 has bsl license
#     export NIXPKGS_ALLOW_UNFREE=1
#
#     if [[ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]]; then
#         . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
#     fi
#     if [[ -e ~/.nix-profile/etc/profile.d/hm-session-vars.sh ]]; then
#         . ~/.nix-profile/etc/profile.d/hm-session-vars.sh
#     fi
# fi

# Paths
for p in \
    "$HOME/Syncthing/SYNC_STUFF/githome/private_dotfiles/topics/tcdn/bin" \
    "$HOME/Syncthing/SYNC_STUFF/githome/private_dotfiles/topics/scripts-private/bin" \
    "$HOME/.local/bin" \
    "$HOME/.local/go/bin"; do
    _prepend_to_path "$p"
done

case $OSTYPE in
linux*)
    export LANG="C.UTF-8"
    export LC_COLLATE="C"
    export LC_MONETARY="es_ES.UTF-8"
    export LC_TIME="es_ES.UTF-8"
    export LC_NUMERIC="es_ES.UTF-8"

    if [[ -n "$WAYLAND_DISPLAY" ]] || [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
        ln -sf "$DOTFILES/topics/shell/bin/wl-copy" ~/.local/bin/pbcopy
        ln -sf "$DOTFILES/topics/shell/bin/wl-paste" ~/.local/bin/pbpaste
        mkdir -p "$HOME/.config/environment.d"
        cp "$DOTFILES/topics/shell/etc/common/environment.d/wayland.conf" "$HOME"/.config/environment.d/
    else
        ln -sf "$DOTFILES/topics/shell/bin/xcopy" ~/.local/bin/pbcopy
        ln -sf "$DOTFILES/topics/shell/bin/xpaste" ~/.local/bin/pbpaste
        rm -f "$HOME"/.config/environment.d/wayland.conf
    fi

    set -a
    shopt -s nullglob
    for f in "$HOME/.config/environment.d"/*; do
        . "$f"
    done
    shopt -u nullglob
    set +a
    ;;
darwin*)
    export LANG="en_US.UTF-8"
    export LANGUAGE="en_US.UTF-8"
    export LC_COLLATE="C"
    export LC_CTYPE="UTF-8"
    export LC_MONETARY="es_ES.UTF-8"
    export LC_TIME="es_ES.UTF-8"
    export LC_NUMERIC="es_ES.UTF-8"

    # Homebrew
    if [[ -e /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
        . /opt/homebrew/etc/profile.d/bash_completion.sh
    fi

    for p in \
        "$HOME/.docker/bin" \
        "/opt/homebrew/opt/coreutils/libexec/gnubin" \
        "/opt/homebrew/opt/findutils/libexec/gnubin" \
        "/opt/homebrew/opt/diffutils/bin" \
        "/opt/homebrew/opt/grep/libexec/gnubin" \
        "/opt/homebrew/opt/gnu-sed/libexec/gnubin" \
        "/opt/homebrew/opt/curl/bin" \
        "/opt/homebrew/opt/util-linux/bin" \
        "/opt/homebrew/opt/openssl@3/bin" \
        "/opt/homebrew/opt/gnu-tar/libexec/gnubin"; do
        _prepend_to_path "$p"
    done
    ;;
*) ;;
esac

# Extra
if [[ -e "$PRIVATE_DOTFILES" ]]; then
    . "$PRIVATE_DOTFILES/topics/tcdn/env/all/bash/04_aliases"
fi

_prepend_to_path_commit
