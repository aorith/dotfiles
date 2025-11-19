#!/usr/bin/env bash

# K8s
if command -v kubectl >/dev/null 2>&1; then
    source <(kubectl completion bash)
    complete -F __start_kubectl k
fi

# GitHub
if command -v gh >/dev/null 2>&1; then
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
