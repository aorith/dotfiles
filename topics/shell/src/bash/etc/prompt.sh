# vim: ft=bash
# Sourced from: bashrc

# Foreground
: "${my_blk:=\[$(tput setaf 0)\]}"   # Black
: "${my_red:=\[$(tput setaf 1)\]}"   # Red
: "${my_grn:=\[$(tput setaf 2)\]}"   # Green
: "${my_ylw:=\[$(tput setaf 3)\]}"   # Yellow
: "${my_blu:=\[$(tput setaf 4)\]}"   # Blue
: "${my_pur:=\[$(tput setaf 5)\]}"   # Purple
: "${my_cyn:=\[$(tput setaf 6)\]}"   # Cyan
: "${my_wht:=\[$(tput setaf 7)\]}"   # White
: "${my_gry:=\[$(tput setaf 8)\]}"   # Grey
: "${my_red2:=\[$(tput setaf 9)\]}"  # Red 2
: "${my_grn2:=\[$(tput setaf 10)\]}" # Green 2
: "${my_ylw2:=\[$(tput setaf 11)\]}" # Yellow 2
: "${my_blu2:=\[$(tput setaf 12)\]}" # Blue 2
: "${my_pur2:=\[$(tput setaf 13)\]}" # Purple 2
: "${my_cyn2:=\[$(tput setaf 14)\]}" # Cyan 2
: "${my_wht2:=\[$(tput setaf 15)\]}" # White 2
: "${my_blk2:=\[$(tput setaf 16)\]}" # Black 2

# Special
: "${my_bld:=\[$(tput bold)\]}" # Bold
: "${my_und:=\[$(tput smul)\]}" # Underline
: "${my_rvs:=\[$(tput rev)\]}"  # Reverse
: "${my_rst:=\[$(tput sgr0)\]}" # Text Reset

# Background
# : "${my_bgblu2:=\[$(tput setab 12)\]}" # Blue2

__ps1_git_info_f() {
    local root branch tag status
    __ps1_git_info=''
    if ! root="$(git rev-parse --show-toplevel 2>/dev/null)"; then
        return
    fi

    # Get the current branch or commit hash if in a detached state
    branch="${root##*/}:${my_bld}$(git symbolic-ref --short HEAD 2>/dev/null || {
        echo -n "D "
        git rev-parse --short HEAD
    })"

    # Check for tag, fallback to commit hash if none
    tag="$(git describe --exact-match HEAD 2>/dev/null)"
    if [[ -n "$tag" ]]; then
        branch="${branch} ${my_blu2}${tag}${my_rst}"
    fi

    # Get the status of the working tree
    if status="$(timeout 0.1 git status --short --untracked-files=all --porcelain)"; then
        if [[ -n "$status" ]]; then
            branch="${branch}${my_rst}${my_gry}:($(wc -l <<<"$status"))"
        fi
    else
        branch="${branch} ${my_rst}${my_gry}(timeout)"
    fi

    __ps1_git_info="${my_grn2}${branch}${my_rst} "
}

__ps1_jobs_f() {
    local n_jobs n_running_jobs
    __ps1_jobs=''
    mapfile -t n_jobs < <(jobs -p)
    ((${#n_jobs[@]} > 0)) || return 0
    mapfile -t n_running_jobs < <(jobs -rp)
    __ps1_jobs="${my_gry}[${#n_running_jobs[@]}/${#n_jobs[@]} jobs]${my_rst} "
}

__prompt_command() {
    local _wd _err OnSSH OnVENV OnNixShell OnContainer Kube Aws
    (($1 == 0)) || _err="${my_red}(${1})${my_rst} "

    __ps1_jobs_f
    __ps1_git_info_f

    if [[ -w "$PWD" ]]; then
        _wd="${my_cyn2}\w${my_rst} "
    else
        _wd="${my_red2}\w${my_rst} "
    fi

    [[ -z "$IN_NIX_SHELL" ]] || OnNixShell="${my_red2}(${name:-unset})${my_rst} "
    [[ -z "$VIRTUAL_ENV_PROMPT" ]] || OnVENV="${my_rst}${my_pur2}venv:${VIRTUAL_ENV_PROMPT}${my_rst} "
    [[ -z "$CONTAINER_ID" ]] || OnContainer="${my_pur2}[$CONTAINER_ID]${my_rst} "
    [[ -z "$KUBECONFIG" ]] || Kube="${my_ylw}k:${KC_CURRENT_CONTEXT:-${KUBECONFIG##*/}}${my_rst} "
    [[ -z "$AWS_PROFILE" ]] || Aws="${my_pur2}a:${AWS_PROFILE}${my_rst} "

    # Initialize PS1 with terminal title
    if [[ -n "$SSH_CLIENT" ]]; then
        PS1='\[\033]0;\u@\h \w\007\]'
        OnSSH="${my_ylw2}${my_bld}\h${my_rst} "
    else
        PS1='\[\033]0;\w\007\]'
    fi

    PS1+="${_err}${_wd}${OnContainer}${OnSSH}${__ps1_git_info}${__ps1_jobs}${OnNixShell}${OnVENV}${Kube}${Aws}${my_blu2}\$${my_rst} "

    # shellcheck disable=SC1003
    printf '\e]133;A\e\\' # prompt marker OSC133
}

PROMPT_COMMAND='__prompt_command $?'
PROMPT_DIRTRIM=4
