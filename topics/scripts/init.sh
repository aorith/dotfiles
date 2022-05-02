# vim: ft=bash

### bootstrap
mkdir -p "${HOME}/bin"
shopt -s nullglob
for script in "${PWD}"/src/scripts/*; do
    link_script_to_home_bin "$script"
done
shopt -u nullglob
###
exit 0
