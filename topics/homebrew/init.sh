# vim: ft=bash

# macos only
case $OSTYPE in
darwin*) true ;;
*)
    log_skip "homebrew"
    exit 0
    ;;
esac

cd "$(dirname -- "$0")" || exit 1

brew update
brew bundle cleanup --force
brew bundle install --upgrade
brew upgrade --cask --greedy

brew services start syncthing >/dev/null 2>&1

exit 0
