#!/usr/bin/env bash

THEMEP="${HOME}/.config/alacritty/themes/alacritty-theme/themes"
CONFIG="${HOME}/.config/alacritty/alacritty.yml"

if [[ "$1" == "reset" ]]; then
    ln -sf ~/.config/alacritty/themes/apprentice.yaml ~/.config/alacritty/theme.yml && \
        cp "${CONFIG}" "/tmp/.alacritty.yml" && \
        echo >> "${CONFIG}" && \
        mv "/tmp/.alacritty.yml" "${CONFIG}"
else
    cd "${THEMEP}" || exit 1
    {
        find . -type f \( -name "*.yml" -o -name "*.yaml" \) -not -name "schemes.yaml";
        find ../../ -type f -maxdepth 1 -mindepth 1 \( -name "*.yml" -o -name "*.yaml" \) -not -name "schemes.yaml"
    } | fzf --preview "head -n 100 {} && ln -sf ${THEMEP}/$(basename {}) ${HOME}/.config/alacritty/theme.yml && cp ${CONFIG} /tmp/.alacritty.yml && echo >> ${CONFIG} && mv /tmp/.alacritty.yml ${CONFIG}"
fi
