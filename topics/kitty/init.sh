#!/usr/bin/env bash

### bootstrap
symlink_env
create_link "${PWD}/src/kitty" "$HOME/.config/kitty"
###
exit 0

