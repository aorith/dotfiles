# vim: ft=bash

create_link "${PWD}/src/yamllint" "$HOME/.config/yamllint"
if [[ ! -d /etc/nixos ]]; then
    create_link "${PWD}/src/nix" "$HOME/.config/nix"
fi

create_link "${PWD}/src/vale" "$HOME/.config/vale"
mkdir -p "$HOME/.config/vale/styles"

if type -f vale >/dev/null 2>&1; then
    (cd ~/.config/vale && vale sync)
elif type -f nix >/dev/null 2>&1; then
    (cd ~/.config/vale && nix run nixpkgs#vale -- sync)
fi

# https://wiki.archlinux.org/title/PipeWire#Noticeable_audio_delay_or_audible_pop/crack_when_starting_playback
case $OSTYPE in
linux*)
    rm -rf ~/.config/wireplumber
    cp -r "${PWD}/src/wireplumber" ~/.config/
    ;;
*) ;;
esac
