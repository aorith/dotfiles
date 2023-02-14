# vim: ft=bash

# macos only
[[ "$(uname -s)" == "Darwin" ]] || exit $_SKIP

brew update
pushd "$(dirname -- "$0")" && { brew bundle; popd >/dev/null || true; }
brew cleanup

###
exit 0
