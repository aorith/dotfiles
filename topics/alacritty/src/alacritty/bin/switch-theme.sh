#!/usr/bin/env bash
set -e

BASET="${HOME}/.config/alacritty/themes"
CONFIG="${HOME}/.config/alacritty/alacritty.toml"

cd "$BASET" || exit 1

if [[ -z "$1" ]]; then
    {
        find mine -type f -name "*.toml" -not -name "schemes.yaml"
    } | fzf --preview "head -n 100 {} && ln -sf ${BASET}/$(basename {}) ${HOME}/.config/alacritty/theme.toml && cp ${CONFIG} /tmp/.alacritty.toml && echo >> ${CONFIG} && mv /tmp/.alacritty.toml ${CONFIG}"
else
    [[ "$(readlink -f "${HOME}"/.config/alacritty/theme.toml)" != "$(readlink -f "${BASET}/${1}")" ]] || exit 0
    ln -sf "${BASET}/${1}" "${HOME}"/.config/alacritty/theme.toml &&
        cp "${CONFIG}" /tmp/.alacritty.toml && echo >>"${CONFIG}" && mv /tmp/.alacritty.toml "${CONFIG}"
fi
