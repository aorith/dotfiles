# vim: ft=bash

create_link "${PWD}/src/yamllint" "$HOME/.config/yamllint"
if [[ ! -d /etc/nixos ]]; then
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
