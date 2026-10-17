#!/usr/bin/env bash

# K8s
# __start_kubectl is lazy-loaded by bash-completion on first "kubectl <TAB>"
_k_completions() {
    declare -F __start_kubectl >/dev/null || _comp_load kubectl 2>/dev/null || __load_completion kubectl
    declare -F __start_kubectl >/dev/null || return
    complete -F __start_kubectl k
    __start_kubectl "$@"
}
if command -v kubectl >/dev/null 2>&1; then
    complete -F _k_completions k
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
    local t
    local -a d=()
    for t in "$DOTFILES"/topics/*/ "$PRIVATE_DOTFILES"/topics/*/; do
        [[ -d "$t" ]] || continue # unmatched glob
        t="${t%/}"
        d+=("${t##*/}")
    done
    compgen -V COMPREPLY -W "${d[*]}" -- "$2"
}
complete -F _dotfiles_completions dotfiles
