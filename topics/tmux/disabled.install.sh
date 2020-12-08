# vim: ft=bash

# macos only
[[ "$(uname -s)" != "Darwin" ]] && exit 0

if ! command -v tmux >/dev/null; then
    log_info "Installing tmux"
    pushd "/tmp/" && \
        git clone https://github.com/tmux/tmux.git && \
        pushd "/tmp/tmux" && \
        sh autogen.sh && ./configure --prefix=/opt/local && make && sudo make install && \
        popd && rm -rf "/tmp/tmux" && \
        popd
    ret=$?
    [[ $ret -ne 0 ]] && { log_error "tmux failed to install."; exit $ret; }
    log_success "tmux installed"
else
    log_success "tmux"
fi

exit 0
