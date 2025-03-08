#!/usr/bin/env bash
set -e

BASET="$HOME/Syncthing/SYNC_STUFF/githome/tinted-shell/scripts"
COLORTEST="$HOME/Syncthing/SYNC_STUFF/githome/private_dotfiles/topics/scripts-private/bin/,colortest"
THEME_TARGET="$HOME/.config/tinted-shell-theme.sh"

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
} | fzf --preview "TTY='$current_tty' bash '$BASET/$(basename {})' && '$COLORTEST' && ln -sf '$BASET/$(basename {})' '$THEME_TARGET'"

sh "$THEME_TARGET"

# Until https://github.com/tmux/tmux/pull/4353 is supported
# I need this so tmux detects the new bg and so does neovim
tmux detach-client
