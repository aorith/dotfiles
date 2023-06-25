# vim: ft=bash

# macos only
[[ "$(uname -s)" == "Darwin" ]] || exit $_SKIP

cd "$(dirname -- "$0")" || exit 1

brew update
brew bundle
brew cleanup
brew bundle cleanup --force

exit 0
