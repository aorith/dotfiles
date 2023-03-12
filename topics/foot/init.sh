# vim: ft=bash
[[ "$_OS" == "Linux" ]] || exit "$_SKIP"

create_link "${PWD}/src/foot" "$HOME/.config/foot"

exit 0
