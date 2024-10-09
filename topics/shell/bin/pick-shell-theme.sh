#!/usr/bin/env bash
set -e

BASET="$HOME/.config/tinted-theming/tinted-shell/scripts"
cd "$BASET" || exit 1

if [[ -n "$TMUX" ]]; then
    # shellcheck disable=SC2155
    current_tty="$(tmux display-message -p "#{pane_tty}")"
else
    # shellcheck disable=SC2155
    current_tty="$(tty)"
fi

{
    find . -type f -name "base*.sh"
} | fzf --preview "TTY='$current_tty' bash '$BASET/$(basename {})' && '$HOME/Syncthing/SYNC_STUFF/githome/private_dotfiles/topics/scripts-private/bin/,colortest' && ln -sf '$BASET/$(basename {})' '$HOME/.config/tinted-shell-theme.sh'"

bash "$HOME/.config/tinted-shell-theme.sh"
