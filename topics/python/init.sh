# vim: ft=bash

# MyPy
create_link "${PWD}/src/mypy" "$HOME/.config/mypy"

# Skip NixOS
[[ ! -d /etc/nixos ]] || exit "$_SKIP"
# Skip Fedora
[[ ! -e /etc/rpm-ostreed.conf ]] || exit "$_SKIP"

# PyENV
[[ -n "$PYENV_ROOT" ]] || { echo "Missing 'PYENV_ROOT' variable."; exit 1; }

_debian_deps() {
    sudo apt update; sudo apt install make build-essential libssl-dev zlib1g-dev \
        libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
        libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
}

_clone_update_pyenv() {
    if [[ ! -e "$PYENV_ROOT" ]]; then
        mkdir -p "$(dirname -- "$PYENV_ROOT")"
        git clone --depth 1 https://github.com/pyenv/pyenv.git "$PYENV_ROOT" >/dev/null && \
            cd "$PYENV_ROOT" && src/configure && make -C src && \
            log_success "Cloned pyenv"
    else
        cd "$PYENV_ROOT" && git pull >/dev/null && log_success "Updated pyenv"
    fi
}

case $HOSTNAME in
    moria*)
        _clone_update_pyenv
        ;;
    debian)
        _debian_deps
        ;;
    *)
        if [[ -n "$_CONTAINER_NAME" ]]; then
            _clone_update_pyenv
        else
            exit "$_SKIP"
        fi
        ;;
esac

### bootstrap
version="3.11.2"
# pyenv install --list  # check python versions
# pyenv install 3.8.6  # install 3.8
# pyenv global 3.8.6  # make it global
# python3 --version  # verify

if [[ "$(pyenv version | awk '{print $1}')" != "$version" ]]; then
    pyenv install "$version"
    pyenv global "$version"
fi
log_success "Using version $version"
unset version
###
exit 0
