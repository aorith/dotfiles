#!/usr/bin/env bash
set -e

BASET="${HOME}/.config/alacritty/themes"
CONFIG="${HOME}/.config/alacritty/alacritty.toml"
THEME_LINK="${HOME}/.config/alacritty/theme.toml"

cd "$BASET" || exit 1

if [[ -z "$1" ]]; then
    original="$(basename -- "$(readlink -f "$THEME_LINK")")"
    restore_cmd="ln -sf '${BASET}/${original}' '$THEME_LINK' && cp '${CONFIG}' /tmp/.alacritty.toml && echo >> '${CONFIG}' && mv /tmp/.alacritty.toml '${CONFIG}'"

    find . -type f -name "*.toml" | fzf \
        --preview "head -n 100 {} && ln -sf '${BASET}/$(basename -- {})' '$THEME_LINK' && cp '${CONFIG}' '/tmp/.alacritty.toml' && echo >> '${CONFIG}' && mv '/tmp/.alacritty.toml' '${CONFIG}'" \
        --bind "esc:execute(${restore_cmd})+abort" \
        --bind "ctrl-c:execute(${restore_cmd})+abort"
else
    [[ "$(readlink -f "$THEME_LINK")" != "$(readlink -f "${BASET}/${1}")" ]] || exit 0
    ln -sf "${BASET}/${1}" "$THEME_LINK" &&
        cp "${CONFIG}" /tmp/.alacritty.toml && echo >>"${CONFIG}" && mv /tmp/.alacritty.toml "${CONFIG}"
fi
