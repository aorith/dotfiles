# vim: ft=bash

# GITHOME & DOTFILES
export GITHOME="${HOME}/githome"
export DOTFILES="${GITHOME}/dotfiles"
export PRIVATE_GITHOME="${HOME}/Syncthing/SYNC_STUFF/githome"
export PRIVATE_DOTFILES="${PRIVATE_GITHOME}/private_dotfiles"

# OS
export _OS="$(uname -s)"

# default umask
umask 022

# Locale
if locale -a 2>/dev/null | grep -qw 'C.UTF-8'; then
    export LANG='C.UTF-8'
    export LC_CTYPE='C.UTF-8'
else
    export LANG='en_US.UTF-8'
fi
export LANGUAGE='en_US.UTF-8'
export LC_COLLATE=C
if [[ -z "$SSH_CLIENT" ]] && [[ ! -f /etc/pacman.conf ]]; then
    export LC_TIME="es_ES.UTF-8"
else
    export LC_TIME=C
fi

if [[ "$_OS" == "Darwin" ]]; then
    # Override CTYPE on MacOs
    export LC_CTYPE=UTF-8
    # MacOs "path_helper" fix ...
    PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
fi

set -a
. "${DOTFILES}/topics/shell/etc/shell/functions"
set +a
. "${DOTFILES}/topics/shell/etc/shell/constants"

export _PROFILE_LOADED=1
