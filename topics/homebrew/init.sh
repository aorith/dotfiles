# vim: ft=bash

# macos only
case $OSTYPE in
darwin*) true ;;
*)
    log_skip "homebrew"
    exit 0
    ;;
esac

_run() {
    log_info "$@"
    "$@"
}

cd "$(dirname -- "$0")" || exit 1

_run brew update
_run brew bundle cleanup --force
_run brew bundle install --upgrade
_run brew upgrade --yes
_run brew upgrade --cask --greedy
_run brew cleanup --prune=all

_run brew services start syncthing >/dev/null 2>&1

exit 0
