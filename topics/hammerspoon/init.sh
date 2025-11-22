# vim: ft=bash

# mac only
case $OSTYPE in
darwin*) true ;;
*)
    log_skip "hammerspoon"
    exit 0
    ;;
esac

### bootstrap
create_link "${PWD}/src/hammerspoon" "$HOME/.hammerspoon"
###
exit 0
