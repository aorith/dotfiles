# vim: ft=bash

create_link "${PWD}/src/alacritty" "$HOME/.config/alacritty"
create_link "${PWD}/src/alacritty/$(uname -s).toml" "${PWD}/src/alacritty/env.toml"

case $OSTYPE in
darwin*)
    defaults write org.alacritty AppleFontSmoothing -int 0
    ;;
*) ;;
esac

exit 0
