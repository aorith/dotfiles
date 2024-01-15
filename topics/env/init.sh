# vim: ft=bash

_ENV_PATH="$HOME/.config/environment.d"

mkdir -p "$_ENV_PATH"
rm -f "$_ENV_PATH"/*

shopt -s nullglob
for f in ./environment.d/*.conf; do
    cp "$f" "$_ENV_PATH"
done
unset f

mkdir -p ~/.local/bin

case $OSTYPE in
linux*)
    if [[ -n "$WAYLAND_DISPLAY" ]] || [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
        ln -sf "$PWD/bin/wl-copy" ~/.local/bin/pbcopy
        ln -sf "$PWD/bin/wl-paste" ~/.local/bin/pbpaste
    else
        ln -sf "$PWD/bin/xcopy" ~/.local/bin/pbcopy
        ln -sf "$PWD/bin/xpaste" ~/.local/bin/pbpaste
    fi

    for f in ./environment.d/Linux/*.conf; do
        cp "$f" "$_ENV_PATH/$(basename -- "${f%%-*}-linux-${f##*-}")"
    done
    ;;
darwin*)
    for f in ./environment.d/Darwin/*.conf; do
        cp "$f" "$_ENV_PATH/$(basename -- "${f%%-*}-darwin-${f##*-}")"
    done
    ;;
esac
