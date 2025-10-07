# vim: ft=bash

# macos only
case $OSTYPE in
darwin*) true ;;
*) exit $_SKIP ;;
esac

cd "$(dirname -- "$0")" || exit 1

brew bundle cleanup --force
#brew bundle check || brew bundle install
brew bundle install --upgrade

brew services start syncthing >/dev/null 2>&1

exit 0
