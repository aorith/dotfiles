# vim: ft=bash

# macos only
[[ "$(uname -s)" == "Darwin" ]] || exit $_SKIP

if ! command -v brew >/dev/null; then
    log_info "Installing homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    ret=$?
    [[ $ret -ne 0 ]] && { log_error "homebrew"; exit $ret; }
    log_success "homebrew installed"
else
    log_success "homebrew"
fi

exit 0
