# vim: ft=bash

### bootstrap
create_link "${PWD}/src/bash/inputrc" "$HOME/.inputrc"
create_link "${PWD}/src/bash/bashrc" "$HOME/.bashrc"
create_link "${PWD}/src/bash/profile" "$HOME/.profile"
create_link "${PWD}/src/bash/bash_profile" "$HOME/.bash_profile"
###
exit 0
