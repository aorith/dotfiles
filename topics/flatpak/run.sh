# vim: ft=sh
# shellcheck shell=bash

set -euo pipefail
cd "$(dirname -- "$0")"

_activate_venv() {
    set +x
    echo "Activating the venv with 'source .venv/bin/activate' ..."
    source .venv/bin/activate || return 1
    set -x
}

if ! type -P ansible-playbook >/dev/null 2>&1; then
    if [[ ! -d .venv ]]; then
        python3 -m venv .venv
        _activate_venv
        python3 -m ensurepip
        python3 -m pip install --upgrade pip
        pip3 install ansible psutil
    else
        _activate_venv
    fi
fi

ansible-playbook playbook.yml

flatpak --user override --filesystem="$HOME/.local/share/fonts"
flatpak --user override --filesystem="$HOME/.icons"
