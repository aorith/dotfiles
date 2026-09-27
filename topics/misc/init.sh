# vim: ft=bash

create_link "${PWD}/src/yamllint" "$HOME/.config/yamllint"
if [[ ! -d /etc/nixos ]] && [[ ! -e "$HOME/.config/nix" ]]; then
    create_link "${PWD}/src/nix" "$HOME/.config/nix"
fi

case $OSTYPE in
linux*)
    mkdir -p "$HOME/.config/wireplumber/wireplumber.conf.d"
    create_link "${PWD}/src/wireplumber/wireplumber.conf.d/51-disable-suspension.conf" \
        "$HOME/.config/wireplumber/wireplumber.conf.d/51-disable-suspension.conf"
    ;;
*) ;;
esac

create_link "${PWD}/src/vale" "$HOME/.config/vale"
if command -v vale >/dev/null 2>&1; then
    VALE="vale"
else
    VALE="$HOME/.local/share/nvim/mason/bin/vale"
fi
if command -v "$VALE" >/dev/null 2>&1; then
    "$VALE" --config ~/.config/vale/vale.ini sync >/dev/null 2>&1
fi

create_link "${PWD}/src/tealdeer" "$HOME/.config/tealdeer"
create_link "${PWD}/src/k9s" "$HOME/.config/k9s"
