# vim: ft=bash

_OS=$(uname -s)
_ENV_PATH="$HOME/.config/environment.d"

mkdir -p "$_ENV_PATH"
rm -f "$_ENV_PATH"/*

shopt -s nullglob
for f in ./environment.d/*.conf; do
    cp "$f" "$_ENV_PATH"
done
unset f

for f in ./environment.d/"$_OS"/*.conf; do
    cp "$f" "$_ENV_PATH/$(basename -- "${f%%-*}-${_OS}-${f##*-}")"
done

# Paths
cat <<EOF >"$_ENV_PATH/20-path.conf"
PATH="$(cat environment.d/path.list environment.d/"${_OS}"/path.list 2>/dev/null | xargs | tr ' ' ':'):\$PATH"
EOF

# Dynamically generated
mkdir -p ~/.local/bin
if [[ "$_OS" == "Linux" ]]; then
    # Linux only
    if [[ -n "$WAYLAND_DISPLAY" ]] || [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
        ln -sf "$PWD/bin/wl-copy" ~/.local/bin/pbcopy
        ln -sf "$PWD/bin/wl-paste" ~/.local/bin/pbpaste
    else
        ln -sf "$PWD/bin/xcopy" ~/.local/bin/pbcopy
        ln -sf "$PWD/bin/xpaste" ~/.local/bin/pbpaste
    fi
fi

exit 0
