# vim: ft=bash
# Sourced from: bashrc

# shellcheck source=./colors.sh
. "${DOTFILES}"/topics/shell/src/bash/etc/colors.sh

__ps1_git_info_f() {
    local branch tag status
    __ps1_git_info=''
    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        return
    fi

    # Get the current branch or commit hash if in a detached state
    branch="${my_bld}$(git symbolic-ref --short HEAD 2>/dev/null || {
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
            branch="${branch} ${my_rst}${my_gry}($(awk '{ count[$1]++; } END { out=""; for (s in count) { if (out != "") { out = out " "; } out = out s ":" count[s]; } print out; }' <<<"$status"))"
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
    local _wd _err OnSSH OnVENV OnNixShell OnContainer
    (($1 == 0)) || _err="${my_red}${1}${my_rst} "

    # background jobs
    __ps1_jobs_f
    # git info
    __ps1_git_info_f

    if [[ -w "${PWD}" ]]; then
        _wd="${my_cyn}\w"
    else
        _wd="${my_red2}\w"
    fi
    [[ -z "$SSH_CLIENT" ]] || OnSSH="${my_ylw2}${my_bld}\h${my_rst} "
    [[ -z "$IN_NIX_SHELL" ]] || OnNixShell="${my_red2}(${name:-unset})${my_rst} "
    [[ -z "$VIRTUAL_ENV_PROMPT" ]] || OnVENV="${my_rst}${my_pur2}venv:${VIRTUAL_ENV_PROMPT:1:-2}${my_rst} "
    [[ -z "$CONTAINER_ID" ]] || OnContainer="${my_pur2}[$CONTAINER_ID]${my_rst} "

    # \d -> date
    # \D{%H:%M:%S} -> date in H:M:S format
    # \t -> time in 24-hour format HH:MM:SS

    printf '\e]133;A\e\\' # prompt start
    PS1="${my_blu2}\t${my_rst} ${OnContainer}\[\033]0;\u@\h \w\007\]${OnSSH}${_wd} ${__ps1_git_info}${my_rst}${__ps1_jobs}${OnNixShell}${OnVENV}${_err}\n${my_blu2}${my_bld}❯${my_rst} "
    printf '\e]133;B\e\\' # prompt end
}

PROMPT_COMMAND='__prompt_command $?'
