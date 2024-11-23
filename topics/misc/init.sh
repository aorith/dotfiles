# vim: ft=bash

create_link "${PWD}/src/yamllint" "$HOME/.config/yamllint"
if [[ ! -d /etc/nixos ]] && [[ ! -e "$HOME/.config/nix" ]]; then
    create_link "${PWD}/src/nix" "$HOME/.config/nix"
fi

# https://wiki.archlinux.org/title/PipeWire#Noticeable_audio_delay_or_audible_pop/crack_when_starting_playback
case $OSTYPE in
linux*)
    rm -rf ~/.config/wireplumber
    cp -r "${PWD}/src/wireplumber" ~/.config/
    ;;
*) ;;
esac

create_link "${PWD}/src/vale" "$HOME/.config/vale"
if type vale >/dev/null 2>&1; then
    VALE="vale"
else
    VALE="$HOME/.local/share/nvim/mason/bin/vale"
fi
if type "$VALE" >/dev/null 2>&1; then
    "$VALE" --config ~/.config/vale/vale.ini sync >/dev/null 2>&1
fi

create_link "${PWD}/src/tealdeer" "$HOME/.config/tealdeer"
