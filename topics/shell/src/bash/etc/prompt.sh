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
    local branch tag status
    __ps1_git_info=''
    __ps1_git_dirty=''
    __ps1_git_root="$(git rev-parse --show-toplevel 2>/dev/null)" || return
    __ps1_git_root="${__ps1_git_root##*/}"

    # Get the current branch or commit hash if in a detached state
    branch="$(git symbolic-ref --short HEAD 2>/dev/null || {
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
        __ps1_git_info="${branch}:(timeout) "
    fi
}

__prompt_command() {
    if (($1 == 0)); then
        _ret=''
    else
        _ret="\[$my_red\]($1)\[$my_rst\] "
    fi

    __ps1_git_info_f
    if [[ -z "$__ps1_git_info" ]]; then
        __ps1_git_final=''
    else
        __ps1_git_final="\[$my_bld\]\[$my_grn\]$__ps1_git_info\[$my_rst\]\[$my_gry\]${__ps1_git_dirty}\[$my_rst\]"
    fi

    # Red color if path is not writable
    local _path_color
    if [[ -w "$PWD" ]]; then
        _path_color="$my_blu"
    else
        _path_color="$my_red2"
    fi

    # Tweak path
    if [[ "$PWD" == "$HOME" ]]; then
        __ps1_path="\[${_path_color}\]~"
    else
        __ps1_path="\[${_path_color}\]"
        local parts i
        IFS='/' read -ra parts <<<"${PWD/~/\~}"
        for i in "${parts[@]}"; do
            case $i in
            "${__ps1_git_root:-path-name-that-will-never-exists}") __ps1_path+="\[${my_bld}${my_und}\]${i}\[${my_rst}\]\[${_path_color}\]/" ;;
            *) __ps1_path+="${i}/" ;;
            esac
        done
    fi
    __ps1_path="${__ps1_path}\[${my_rst}\]"

    # Print bg jobs when they exist
    if [[ -z "$(jobs -p)" ]]; then
        _jobs=''
    else
        _jobs="\[$my_gry\][\j jobs]\[$my_rst\] "
    fi

    # If nix shell is active ...
    if [[ -z "$IN_NIX_SHELL" ]]; then
        _nix_shell=''
    else
        _nix_shell="\[$my_red2\](${name:-unset})\[$my_rst\] "
    fi

    # If python venv is active ...
    if [[ -z "$VIRTUAL_ENV_PROMPT" ]]; then
        _venv=''
    else
        _venv="\[$my_pur2\]venv:${VIRTUAL_ENV_PROMPT}\[$my_rst\] "
    fi

    # If KUBECONFIG is set ...
    if [[ -z "$KUBECONFIG" ]]; then
        _kube=''
    else
        _kube="\[$my_ylw\][K:${KC_CURRENT_CONTEXT:-${KUBECONFIG##*/}}]\[$my_rst\] "
    fi

    # If AWS_PROFILE is set ...
    if [[ -z "$AWS_PROFILE" ]]; then
        _aws=''
    else
        _aws="\[$my_pur2\][A:${AWS_PROFILE}]\[$my_rst\] "
    fi
}

PS1='\n${_ret@P}${_jobs@P}'
if [[ -n "$CONTAINER_ID" ]]; then
    PS1+="\[$my_pur2\][$CONTAINER_ID]\[$my_rst\] "
fi
if [[ -n "$SSH_CLIENT" ]]; then
    PS1+="\[\033]0;\u@\h \w\007\]\[$my_ylw2\]\h\[$my_rst\] "
else
    case "$TERM" in
    *kitty*)
        # Since kitty can't tell if the tab title has been manually set..., use a static title here: "bash"
        # and display the current executable if the title is "bash" on kitty's "tab_title_template"
        PS1+='\[\033]0;bash\007\]'
        ;;
    *)
        PS1+='\[\033]0;\w\007\]'
        ;;
    esac
fi
PS1+='${__ps1_path@P} ${__ps1_git_final@P}'
PS1+='${_nix_shell@P}${_venv@P}'
PS1+='${_kube@P}${_aws@P}'
PS1+='\[${my_blu2}\]\n\$\[$my_rst\] '

PROMPT_COMMAND='__prompt_command $?'
