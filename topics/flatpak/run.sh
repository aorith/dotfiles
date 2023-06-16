# vim: ft=sh
# shellcheck shell=bash

set -euo pipefail
cd "$(dirname -- "$0")"

ansible-playbook playbook.yml

flatpak --user override --filesystem="$HOME/.local/share/fonts"
flatpak --user override --filesystem="$HOME/.icons"
