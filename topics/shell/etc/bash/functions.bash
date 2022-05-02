# vim: ft=bash

add_to_path() {
    # add_to_path <path> [last]
    [[ -n "$1" ]] || return 1
    case ":${PATH}:" in
        *":${1}:"*) ;; # already there
        *) [[ "$2" == "last" ]] && PATH="${PATH}:${1}" || PATH="${1}:${PATH}";;
    esac
    export PATH
}

add_to_manpath() {
    # add_to_manpath <path> [last]
    [[ -n "$1" ]] || return 1
    case ":${MANPATH}:" in
        *":${1}:"*) ;; # already there
        *) [[ "$2" == "last" ]] && MANPATH="${MANPATH}:${1}" || MANPATH="${1}:${MANPATH}";;
    esac
    export MANPATH
}

link_script_to_home_bin() {
    [[ -n $1 ]] || return 1
    [[ $1 =~ ^/.+ ]] || return 1 # (full path only)
    filename=$(basename -- "$1") || return 1
    destination="${HOME}/bin/${filename}"
    if [[ -e "$destination" ]]; then
        if ! diff "$1" "$destination" &>/dev/null; then
            printf 'WARN: could not copy %s to ~/bin, another script has the same name.\n' "$filename"
        fi
    else
        [[ -L "$destination" ]] && rm "$destination" # broken link
        ln -s "$1" "$destination"
    fi
}

# tests if $1 > $2
_greater_than() {
    [ ${1%.*} -eq ${2%.*} ] && [ ${1#*.} \> ${2#*.} ] || [ ${1%.*} -gt ${2%.*} ]
}

# Easy CD into dotfiles, must be a function
dotfiles() {
    [[ -n "$1" ]] || { echo "Changing dir to $DOTFILES"; cd "$DOTFILES" || return 1; return 0; }
    for topic in $DOTFILES/topics/* $PRIVATE_DOTFILES/topics/*; do
        if basename -- "$topic" | grep -Ewq "$1"; then
            cd "$topic" && echo "Found $1 ... changing directory." && return 0
        fi
    done
    echo "Unable to find topic: \"$1\"."; return 1;
}
