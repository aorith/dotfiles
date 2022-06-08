# vim: ft=bash

_debian_deps() {
    sudo apt update; sudo apt install make build-essential libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
        libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
}

case $(hostname) in
    moria*)
        brew install --formulae "pyenv"
        ;;
    debian)
        _debian_deps
        ;;
    *) exit "$_SKIP" ;;
esac

[[ -n "$PYENV_ROOT" ]] || exit 1

if [[ ! -e "$PYENV_ROOT" ]]; then
    mkdir -p "$(dirname -- "$PYENV_ROOT")"
    git clone --depth 1 https://github.com/pyenv/pyenv.git "$PYENV_ROOT"
fi
if [[ ! -e "$PYENV_ROOT"/plugins/pyenv-virtualenv ]]; then
    git clone --depth 1 https://github.com/pyenv/pyenv-virtualenv.git "$PYENV_ROOT"/plugins/pyenv-virtualenv
fi

### bootstrap
version="3.10.4"
# pyenv install --list  # check python versions
# pyenv install 3.8.6  # install 3.8
# pyenv global 3.8.6  # make it global
# python3 --version  # verify

pyenv install "$version"
pyenv global "$version"
unset version
###
exit 0
