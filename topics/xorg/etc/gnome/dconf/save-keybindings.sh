#!/usr/bin/env bash

dconf dump /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/ > custom-keybindings.conf
dconf dump /org/gnome/desktop/wm/keybindings/ > gnome-keybindings.conf

