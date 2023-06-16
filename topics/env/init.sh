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
cat <<EOF>"$_ENV_PATH/20-path.conf"
PATH="$(cat environment.d/path.list environment.d/"${_OS}"/path.list 2>/dev/null | xargs | tr ' ' ':'):\$PATH"
EOF

# Dynamically generated
if [[ "$_OS" == 'Linux' ]]; then
    # Linux only
    if [[ -n "$WAYLAND_DISPLAY" ]] || [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
        cat <<EOF >"$_ENV_PATH/50-clipboard.conf"
CLIPBOARD_COPY="wl-copy"
CLIPBOARD_PASTE="wl-paste"
EOF
    else
        cat <<EOF >"$_ENV_PATH/50-clipboard.conf"
CLIPBOARD_COPY="xclip -i -selection clipboard"
CLIPBOARD_PASTE="xclip -out -selection clipboard"
EOF
    fi
fi

exit 0
