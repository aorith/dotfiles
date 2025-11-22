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

brew bundle cleanup --force
#brew bundle check || brew bundle install
brew bundle install --upgrade

brew services start syncthing >/dev/null 2>&1

exit 0
