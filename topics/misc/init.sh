# vim: ft=bash

create_link "${PWD}/src/yamllint" "$HOME/.config/yamllint"
create_link "${PWD}/src/nix" "$HOME/.config/nix"

create_link "${PWD}/src/vale" "$HOME/.config/vale"
mkdir -p "$HOME/.config/vale/styles"

if type vale >/dev/null 2>&1; then
    (cd ~/.config/vale && vale sync)
fi

# https://wiki.archlinux.org/title/PipeWire#Noticeable_audio_delay_or_audible_pop/crack_when_starting_playback
case $OSTYPE in
linux*)
    rm -rf ~/.config/wireplumber
    cp -r "${PWD}/src/wireplumber" ~/.config/
    ;;
*) ;;
esac
