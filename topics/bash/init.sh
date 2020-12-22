#!/usr/bin/env bash

### bootstrap
symlink_env
create_link "${PWD}/src/bashrc" "$HOME/.bashrc"
create_link "${PWD}/src/profile" "$HOME/.profile"
create_link "${PWD}/src/bash_profile" "$HOME/.bash_profile"
###
exit 0
