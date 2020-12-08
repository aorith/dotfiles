#!/usr/bin/env bash

### bootstrap
create_link "${PWD}/src/tmux" "$HOME/.config/tmux"

current_user=$(whoami)
# Ncurses terminfo
#curl -o /tmp/terminfo.gz -sL 'https://invisible-island.net/datafiles/current/terminfo.src.gz' && gunzip -f /tmp/terminfo.gz
#sudo /usr/bin/tic -xe tmux-256color /tmp/terminfo
#rm -f /tmp/terminfo*

# Tmux maintaner terminfo
sudo /usr/bin/tic -x "etc/tmux-256color"
[[ -d "/root" ]] && sudo cp -r ~/.terminfo /root/
[[ -d "/var/root" ]] && sudo cp -r ~/.terminfo /var/root/
sudo chown -R ${current_user}: ~/.terminfo
unset current_user

###
exit 0
