# vim: ft=bash

### bootstrap

if [[ -e /etc/nixos ]]; then
    create_link "$PWD/justfiles/nixos.justfile" "$HOME/.justfile"
fi
