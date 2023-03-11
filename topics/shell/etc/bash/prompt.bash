# vim: ft=bash
# Sourced from: bashrc

# shellcheck source=./colors.bash
. "${DOTFILES}"/topics/shell/etc/bash/colors.bash

__container_check() {
    [[ -n "$CONTAINER_ID" ]] || return
    printf ' %b%s%b ' "${my_pur2}" "[$CONTAINER_ID]" "${my_rst}"
}

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
                _ps1_git_branch="${my_bld}${my_grn2} ${h##*/}${my_rst}"
                return 0
                ;;
            "")
                _ps1_git_branch=''
                return 0
                ;;
            *)
                _ps1_git_branch="${my_bld}${my_grn2} D ${h:0:7}$(__ps1_git_tag_f)${my_rst}"
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
    (( ${#n_jobs[@]} > 0 )) || return 0
    mapfile -t n_running_jobs < <(jobs -rp)
    _ps1_jobs="${my_gry} ${#n_running_jobs[@]}/${#n_jobs[@]}${my_rst}"
}

__prompt_command() {
    local LANG=C
    local wdc ep OnSSH ms tc _nl # working directory color, error prompt, on ssh, millisecods, timecolor, newline
    (($1 == 0)) || ep="${my_red}${1}${my_rst} "

    ms=$((($(${EXEC_DATE} +%s%N) - ${_ps1_start_timer:-}) / 1000000))
    case $((\
    ms < 21 ? 1 : \
    ms < 101 ? 2 : \
    ms < 251 ? 3 : \
    ms < 501 ? 4 : \
    ms < 1000 ? 5 : 6)) in
    1) tc="${my_grn}" ;;
    2) tc="${my_ylw}" ;;
    3) tc="${my_cyn}" ;;
    4) tc="${my_blu}" ;;
    5) tc="${my_pur}" ;;
    6 | *) tc="${my_red}" ms=$((ms / 1000)) ;;
    esac
    ms="$(printf '%03d' "$ms")"

    # git branch/tag
    __ps1_git_branch_f

    # background jobs
    __ps1_jobs_f

    OnContainer=$(__container_check)

    if [[ -w "${PWD}" ]]; then
        ((${#PWD} < 30)) || _nl='\n'
        wdc="${my_cyn}\w"
    else
        wdc="${my_red2}\w"
        _nl='\n'
    fi
    [[ -z "$SSH_CLIENT" ]] || OnSSH="${my_ylw2}${my_bld}\h${my_rst} "
    [[ -z "$IN_NIX_SHELL" ]] || OnNixShell=" ${my_red2}(${name:-unset})${my_rst}"
    [[ -z "$VIRTUAL_ENV" ]] || OnVENV=" ${my_rst}(venv)"

    PS1="\[\033]0;\u@\h \w\007\]${tc}${ms}${my_rst} ${OnSSH}${wdc}${OnVENV}${_ps1_git_branch}${my_rst}${_ps1_jobs}${OnNixShell}${OnContainer}${ep}${_nl}${my_grn2}❯${my_rst} "

    unset _ps1_start_timer
}

trap ': "${_ps1_start_timer:=$($EXEC_DATE +%s%N)}"' DEBUG
PROMPT_COMMAND='__prompt_command $?'
