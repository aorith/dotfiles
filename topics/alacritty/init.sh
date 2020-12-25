# vim: ft=bash

### bootstrap
create_link "${PWD}/src/alacritty" "$HOME/.config/alacritty"

# macos only
[[ "$(uname -s)" != "Darwin" ]] && exit 0

if ! infocmp alacritty &>/dev/null; then
    [[ -n "$SSH_CLIENT" ]] && { log_warn "Not bootstrapping terminfo over ssh"; exit 0; }
    current_user=$(whoami)
    sudo tic -xe alacritty,alacritty-direct etc/alacritty.info
    [[ -d "/root" ]] && sudo cp -r ~/.terminfo /root/
    [[ -d "/var/root" ]] && sudo cp -r ~/.terminfo /var/root/
    sudo mkdir -p /usr/local/share/man/man1
    sudo cp etc/alacritty.1.gz /usr/local/share/man/man1/
    sudo chown -R ${current_user}: ~/.terminfo
    sudo chown -R ${current_user}: /usr/local/share/man/man1/alacritty.1.gz
    unset version current_user
fi
###
exit 0
