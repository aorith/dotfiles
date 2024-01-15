# vim: ft=bash

# mac only
case $OSTYPE in
darwin*) true ;;
*) exit $_SKIP ;;
esac

### bootstrap
create_link "${PWD}/src/hammerspoon" "$HOME/.hammerspoon"
###
exit 0
