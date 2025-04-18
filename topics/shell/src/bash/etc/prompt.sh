# vim: ft=bash
# Sourced from: bashrc

# shellcheck disable=SC2034
if [[ -z "$my_blk" ]]; then
    set -a
    my_blk="$(tput setaf 0)"   # Black
    my_red="$(tput setaf 1)"   # Red
    my_grn="$(tput setaf 2)"   # Green
    my_ylw="$(tput setaf 3)"   # Yellow
    my_blu="$(tput setaf 4)"   # Blue
    my_pur="$(tput setaf 5)"   # Purple
    my_cyn="$(tput setaf 6)"   # Cyan
    my_whi="$(tput setaf 7)"   # White
    my_gry="$(tput setaf 8)"   # Grey
    my_red2="$(tput setaf 9)"  # Red 2
    my_grn2="$(tput setaf 10)" # Green 2
    my_ylw2="$(tput setaf 11)" # Yellow 2
    my_blu2="$(tput setaf 12)" # Blue 2
    my_pur2="$(tput setaf 13)" # Purple 2
    my_cyn2="$(tput setaf 14)" # Cyan 2
    my_whi2="$(tput setaf 15)" # White 2
    my_blk2="$(tput setaf 16)" # Black 2
    my_bld="$(tput bold)"      # Bold
    my_und="$(tput smul)"      # Underline
    my_rvs="$(tput rev)"       # Reverse
    my_rst="$(tput sgr0)"      # Text Reset
    set +a
fi

__ps1_git_info_f() {
    local root branch tag status
    __ps1_git_info=''
    __ps1_git_dirty=''
    root="$(git rev-parse --show-toplevel 2>/dev/null)" || return

    # Get the current branch or commit hash if in a detached state
    branch="${root##*/}:$(git symbolic-ref --short HEAD 2>/dev/null || {
        printf 'D:'
        git rev-parse --short HEAD
    })"

    # Check for tag, fallback to commit hash if none
    tag="$(git describe --exact-match HEAD 2>/dev/null)"
    if [[ -n "$tag" ]]; then
        branch="${branch} ${tag}"
    fi

    # Get the status of the working tree
    # and set the final values for __ps1_git_info and __ps1_git_dirty
    if status="$(timeout 0.1 git status --short --untracked-files=all --porcelain 2>/dev/null)"; then
        if [[ -n "$status" ]]; then
            __ps1_git_info="${branch}:"
            __ps1_git_dirty="($(wc -l <<<"$status")) "
        else
            __ps1_git_info="${branch} "
        fi
    else
        __ps1_git_info="${branch}:(timeout)"
    fi
}

__prompt_command() {
    if (($1 == 0)); then
        _ret=''
    else
        _ret="($1) "
    fi

    __ps1_git_info_f

    # Newline if path is longer than ...
    if ((${#PWD} > 65)); then
        _ps1_newline='\n'
    else
        _ps1_newline=''
    fi

    # Red color if path is not writable
    if [[ -w "$PWD" ]]; then
        _path_color="$my_cyn2"
    else
        _path_color="$my_red2"
    fi

    # Print bg jobs when they exist
    if [[ -z "$(jobs -p)" ]]; then
        _jobs=''
    else
        _jobs="[\j jobs] "
    fi

    # If nix shell is active ...
    if [[ -z "$IN_NIX_SHELL" ]]; then
        _nix_shell=''
    else
        _nix_shell="(${name:-unset}) "
    fi

    # If python venv is active ...
    if [[ -z "$VIRTUAL_ENV_PROMPT" ]]; then
        _venv=''
    else
        _venv="venv:${VIRTUAL_ENV_PROMPT} "
    fi

    # If KUBECONFIG is set ...
    if [[ -z "$KUBECONFIG" ]]; then
        _kube=''
    else
        _kube="k:${KC_CURRENT_CONTEXT:-${KUBECONFIG##*/}} "
    fi

    # If AWS_PROFILE is set ...
    if [[ -z "$AWS_PROFILE" ]]; then
        _aws=''
    else
        _aws="a:${AWS_PROFILE} "
    fi
}

PS1='\[$my_red\]$_ret\[$my_rst\]\[$my_gry\]${_jobs@P}\[$my_rst\]'
if [[ -n "$CONTAINER_ID" ]]; then
    PS1+="\[$my_pur2\][$CONTAINER_ID]\[$my_rst\] "
fi
if [[ -n "$SSH_CLIENT" ]]; then
    PS1+="\[\033]0;\u@\h \w\007\]\[$my_ylw2\]\h\[$my_rst\] "
else
    PS1+='\[\033]0;\w\007\]'
fi
PS1+='\[$_path_color\]\w\[$my_rst\] \[$my_grn\]$__ps1_git_info\[$my_rst\]\[$my_gry\]${__ps1_git_dirty}\[$my_rst\]'
PS1+='\[$my_red2\]$_nix_shell\[$my_rst\]\[$my_pur2\]$_venv\[$my_rst\]'
PS1+='\[$my_ylw\]$_kube\[$my_rst\]\[$my_pur2\]$_aws\[$my_rst\]'
PS1+='\[\e]133;L\a\e]133;A\a${my_blu2}\]${_ps1_newline@P}\$\[$my_rst\] '

PROMPT_COMMAND='__prompt_command $?'
PROMPT_DIRTRIM=7
