# vim: ft=bash

create_link "${PWD}/src/yamllint" "$HOME/.config/yamllint"
create_link "${PWD}/src/nix" "$HOME/.config/nix"

create_link "${PWD}/src/vale" "$HOME/.config/vale"
mkdir -p "$HOME/.config/vale/styles"

if type vale >/dev/null 2>&1; then
    (cd ~/.config/vale && vale sync)
fi
