# vim: ft=bash

__ps1_git_tag_f() {
    local t # tag
    t="$(git describe --tags --abbrev=0 2>/dev/null)"
    [[ -z "${t}" ]] || printf ":${t}"
}

__ps1_git_branch_f() {
    local d h # dir, head
    d="$(pwd -P)"
    _ps1_git_branch=''
    while [[ -n "${d}" ]]; do
        if [[ -e "${d}/.git/HEAD" ]]; then
            read -r h < "${d}/.git/HEAD"
            case "${h}" in
                ref:*)
                    _ps1_git_branch="${my_ylw}:${h##*/}$(__ps1_git_tag_f)${my_rst}"
                    return 0
                    ;;
                "")
                    _ps1_git_branch=''
                    return 0
                    ;;
                *)
                    _ps1_git_branch="${my_ylw}:D:${h:0:7}$(__ps1_git_tag_f)${my_rst}"
                    return 0
                    ;;
            esac
            break
        fi
        d="${d%/*}"
    done
}

__ps1_jobs_f() {
    local j rj # jobs, running_jobs
    _ps1_jobs=''
    j=( $(jobs -p) )
    [[ -n "${j[*]}" ]] || return 0
    rj=( $(jobs -rp) )
    _ps1_jobs="${my_gry}:${#rj[@]}/${#j[@]}${my_rst}"
}

__prompt_command () {
    local le=$? LANG=C # last exit
    local wdc ep onssh ms tc # working directory color, error prompt, on ssh, millisecods, timecolor
    (( $le > 0 )) && ep="${my_red}:${le}${my_rst}" || unset ep

    ms=$(( ($(${EXEC_DATE} +%s%N) - ${_ps1_start_timer:-}) / 1000000 ))

    # different foreground color for the time
    # depending on the execution time.
    case $((
        ms <= 20   ? 1 :
        ms <= 100  ? 2 :
        ms <= 250  ? 3 :
        ms <= 500  ? 4 :
        ms <= 999  ? 5 : 6)) in
        (1)   tc="${my_grn}" ;;
        (2)   tc="${my_ylw}" ;;
        (3)   tc="${my_cyn}" ;;
        (4)   tc="${my_blu}" ;;
        (5)   tc="${my_pur}" ;;
        # when more then 1000 ms have elapsed,
        # display seconds, (ms/1000), instead.
        (6|*) tc="${my_red}" ms=$((ms/1000)) ;;
    esac

    # format time, 3 characters pad with zero
    # (ms = 42 -> 042)
    ms="$(printf '%03d' $ms)"

    # mostramos rama si es un repo git
    __ps1_git_branch_f

    # mostramos jobs en background
    __ps1_jobs_f

    [[ -w "${PWD}" ]] && wdc="${my_cyn}" || wdc="${my_red2}"
    [[ -z "$SSH_CLIENT" ]] || onssh="${my_grn}\h:${my_rst}"

    PS1="\[\033]0;\u@\h:\w\007\]${tc}${ms}${my_rst} ${onssh}${wdc}\w${_ps1_git_branch}${my_rst}${_ps1_jobs}${ep} ${my_blu}❯${my_rst} "

    unset _ps1_start_timer
}

trap ': "${_ps1_start_timer:=$($EXEC_DATE +%s%N)}"' DEBUG
PROMPT_COMMAND='__prompt_command'
