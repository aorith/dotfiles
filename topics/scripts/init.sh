# vim: ft=bash

### bootstrap
_SCRIPTS_DIR="${HOME}/.local/myscripts"

_link_script() {
    [[ -n $1 ]]                  || return 1
    [[ $1 =~ ^/.+ ]]             || return 1 # (full path only)
    filename=$(basename -- "$1") || return 1
    destination="${_SCRIPTS_DIR}/${filename}"
    if [[ -e "$destination" ]]; then
        if ! diff "$1" "$destination" >/dev/null 2>&1; then
            printf 'WARN: could not copy "%s" to "%s", another script has the same name.\n' "$_SCRIPTS_DIR" "$filename"
        fi
    else
        [[ ! -L "$destination" ]] || rm "$destination" # broken link
        ln -s "$(realpath "$1")" "$destination"
    fi
}
mkdir -p "$_SCRIPTS_DIR"

if [[ "$1" != "source-only" ]]; then
    shopt -s nullglob
    for script in "${PWD}"/src/scripts/*; do
        _link_script "$script"
    done
    shopt -u nullglob
    unset _link_script
    unset _SCRIPTS_DIR

    ###
    exit 0
fi
