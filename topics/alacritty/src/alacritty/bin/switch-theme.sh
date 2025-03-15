#!/usr/bin/env bash
set -e

BASET="${HOME}/.config/alacritty/themes"
CONFIG="${HOME}/.config/alacritty/alacritty.toml"
THEME_LINK="${HOME}/.config/alacritty/theme.toml"

cd "$BASET" || exit 1

if [[ -z "$1" ]]; then
    {
        find . -type f -name "*.toml"
    } | fzf --preview "head -n 100 {} && ln -sf '${BASET}/$(basename -- {})' '$THEME_LINK' && cp '${CONFIG}' '/tmp/.alacritty.toml' && echo >> '${CONFIG}' && mv '/tmp/.alacritty.toml' '${CONFIG}'"
else
    [[ "$(readlink -f "$THEME_LINK")" != "$(readlink -f "${BASET}/${1}")" ]] || exit 0
    ln -sf "${BASET}/${1}" "$THEME_LINK" &&
        cp "${CONFIG}" /tmp/.alacritty.toml && echo >>"${CONFIG}" && mv /tmp/.alacritty.toml "${CONFIG}"
fi
