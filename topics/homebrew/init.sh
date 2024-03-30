# vim: ft=bash

# macos only
case $OSTYPE in
darwin*) true ;;
*) exit $_SKIP ;;
esac

cd "$(dirname -- "$0")" || exit 1

brew update
brew bundle
brew upgrade
brew cleanup
brew bundle cleanup --force

exit 0
