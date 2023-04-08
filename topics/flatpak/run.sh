#!/usr/bin/env nix-shell
#!nix-shell -i bash -p ansible

# shellcheck shell=bash
# vim: ft=sh

set -euo pipefail
cd "$(dirname -- "$0")"

ansible-playbook playbook.yml

flatpak --user override --filesystem="$HOME/.local/share/fonts"
flatpak --user override --filesystem="$HOME/.icons"
