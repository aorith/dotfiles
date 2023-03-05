#!/usr/bin/env bash
set -e

BASET="${HOME}/.config/alacritty/themes"
CONFIG="${HOME}/.config/alacritty/alacritty.yml"

cd "$BASET" || exit 1

if [[ -z "$1" ]]; then
    {
        find mine/ -type f \( -name "*.yml" -o -name "*.yaml" \) -not -name "schemes.yaml"
        find zenbones/ -type f \( -name "*.yml" -o -name "*.yaml" \) -not -name "schemes.yaml"
    } | fzf --preview "head -n 100 {} && ln -sf ${BASET}/$(basename {}) ${HOME}/.config/alacritty/theme.yml && cp ${CONFIG} /tmp/.alacritty.yml && echo >> ${CONFIG} && mv /tmp/.alacritty.yml ${CONFIG}"
else
    [[ "$(readlink -f "${HOME}"/.config/alacritty/theme.yml)" != "$(readlink -f "${BASET}/${1}")" ]] || exit 0
    ln -sf "${BASET}/${1}" "${HOME}"/.config/alacritty/theme.yml &&
        cp "${CONFIG}" /tmp/.alacritty.yml && echo >>"${CONFIG}" && mv /tmp/.alacritty.yml "${CONFIG}"
fi
