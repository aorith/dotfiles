#!/usr/bin/env bash

# K8s
if type -f kubectl >/dev/null 2>&1; then
    source <(kubectl completion bash)
    complete -F __start_kubectl k
fi

# GitHub
if type -f gh >/dev/null 2>&1; then
    source <(gh completion --shell bash)
fi

# ------------------ bash completion basics ------------------ #

# ---- this loads when the shell starts
# complete -W "$(script-that-outputs-completions)" script-to-add-completion-to

# ---- this loads each time TAB is presset
# _script_completions() {
#   COMPREPLY=($(compgen -W "$(script-that-outputs-completions)"))
# }
# complete -F _script_completions script

# ------------------------------------------------------------ #

# Adds completion to the "dotfiles" function
_dotfiles_completions() {
    mapfile -t COMPREPLY < <(compgen -W "$(
        find "$DOTFILES/topics/" -maxdepth 1 -mindepth 1 -type d -exec basename {} \;
        find "$PRIVATE_DOTFILES/topics/" -maxdepth 1 -mindepth 1 -type d -exec basename {} \;
    )" "${COMP_WORDS[1]}")
}
complete -F _dotfiles_completions dotfiles

_tes_completions() {
    mapfile -t COMPREPLY < <(sed -n '/options = {/,/}/p' "$PRIVATE_DOTFILES/topics/tcdn/bin/tes" | grep -Eo '".*"' | tr -d '"' | grep -E "^${2}")
}
complete -F _tes_completions -o default tes

# zk completion
_zk_completions() {
    local _zk_aliases
    _zk_aliases() {
        echo -e "n\tNew Note"
        echo -e "nj\tNew Journal"
        echo -e "e\tList & Edit Notes"
        echo -e "ea\tList & Edit All"
        echo -e "ej\tList & Edit Journals"
    }

    local selected
    selected=$(_zk_aliases | fzf --layout reverse --margin 10%)

    if [[ -n "$selected" ]]; then
        COMPREPLY=("${selected%%$'\t'*}")
    else
        COMPREPLY=()
    fi
}

# _zk_completions() {
#     local cur prev opts
#     cur="${COMP_WORDS[COMP_CWORD]}"      # Current word being completed
#     prev="${COMP_WORDS[COMP_CWORD - 1]}" # Previous word
#     opts="n nj e ea ej"                  # Aliases to be completed
#
#     # Only suggest aliases if "zk" is the first word
#     if [[ ${#COMP_WORDS[@]} -eq 2 ]]; then
#         mapfile -t COMPREPLY < <(compgen -W "$opts" -- "$cur")
#     else
#         COMPREPLY=()
#     fi
# }
complete -F _zk_completions zk
