# vim: ft=bash
# Sourced from: bashrc

# shellcheck source=./colors.bash
. "${DOTFILES}"/topics/shell/etc/bash/colors.bash

__ps1_git_tag_f() {
    local t # tag
    t="$(timeout 0.5 git describe --tags --abbrev=0 2>/dev/null)"
    if [[ $? -eq 124 ]]; then
        t='git-timeout'
        pgrep '[g]it describe' 2>/dev/null || { git describe --tags --abbrev=0 >/dev/null 2>&1 & }
    fi
    printf '%s %s' "${my_pur}" "${t}"
}

__ps1_git_branch_f() {
    local d h # dir, head
    d="$(pwd -P)"
    _ps1_git_branch=''
    while [[ -n "${d}" ]]; do
        if [[ -e "${d}/.git/HEAD" ]]; then
            read -r h <"${d}/.git/HEAD"
            case "${h}" in
            ref:*)
                _ps1_git_branch="${my_bld}${my_grn2}${h##*/}${my_rst} "
                return 0
                ;;
            "")
                _ps1_git_branch=''
                return 0
                ;;
            *)
                _ps1_git_branch="${my_bld}${my_grn2}D ${h:0:7}$(__ps1_git_tag_f)${my_rst} "
                return 0
                ;;
            esac
        fi
        d="${d%/*}"
    done
}

__ps1_jobs_f() {
    local n_jobs n_running_jobs
    _ps1_jobs=''
    mapfile -t n_jobs < <(jobs -p)
    ((${#n_jobs[@]} > 0)) || return 0
    mapfile -t n_running_jobs < <(jobs -rp)
    _ps1_jobs="${my_gry}${#n_running_jobs[@]}/${#n_jobs[@]}${my_rst} "
}

__prompt_command() {
    local LANG=C
    local wdc ep OnSSH _nl # working directory color, error prompt, on ssh, millisecods, timecolor, newline
    (($1 == 0)) || ep="${my_red}${1}${my_rst} "

    # git branch/tag
    __ps1_git_branch_f

    # background jobs
    __ps1_jobs_f

    if [[ -w "${PWD}" ]]; then
        ((${#PWD} < 48)) || _nl='\n'
        wdc="${my_cyn}\w"
    else
        wdc="${my_red2}\w"
        _nl='\n'
    fi
    [[ -z "$SSH_CLIENT" ]] || OnSSH="${my_ylw2}${my_bld}\h${my_rst} "
    [[ -z "$IN_NIX_SHELL" ]] || OnNixShell="${my_red2}(${name:-unset})${my_rst} "
    [[ -z "$VIRTUAL_ENV" ]] || OnVENV="${my_rst}(venv) "
    [[ -z "$CONTAINER_ID" ]] || OnContainer="${my_pur2}[$CONTAINER_ID]${my_rst} "

    PS1="${my_blu2}♯${my_rst} \[\033]0;\u@\h \w\007\]${OnSSH}${wdc} ${OnVENV}${_ps1_git_branch}${my_rst}${_ps1_jobs}${OnNixShell}${OnContainer}${ep}${_nl}${my_blu2}❯${my_rst} "
}

PROMPT_COMMAND='__prompt_command $?'
