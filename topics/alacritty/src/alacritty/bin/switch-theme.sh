#!/usr/bin/env bash

BASET="${HOME}/.config/alacritty/themes"
CONFIG="${HOME}/.config/alacritty/alacritty.yml"

if [[ "$1" == "reset" ]]; then
    ln -sf ~/.config/alacritty/themes/mine/apprentice.yaml ~/.config/alacritty/theme.yml && \
        cp "${CONFIG}" "/tmp/.alacritty.yml" && \
        printf '\n\n' >> "${CONFIG}" && \
        mv "/tmp/.alacritty.yml" "${CONFIG}"
else
    cd "$BASET" || exit 1
    {
        find mine -type f \( -name "*.yml" -o -name "*.yaml" \) -not -name "schemes.yaml";
        #find alacritty-theme/themes -type f \( -name "*.yml" -o -name "*.yaml" \) -not -name "schemes.yaml";
        #find tempus-themes-alacritty -maxdepth 1 -mindepth 1 -type f \( -name "*.yml" -o -name "*.yaml" \) -not -name "schemes.yaml";
    } | fzf --preview "head -n 100 {} && ln -sf ${BASET}/$(basename {}) ${HOME}/.config/alacritty/theme.yml && cp ${CONFIG} /tmp/.alacritty.yml && echo >> ${CONFIG} && mv /tmp/.alacritty.yml ${CONFIG}"
fi
