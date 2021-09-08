# vim: ft=bash
# Sourced from: bashrc

__ps1_git_tag_f() {
    local t # tag
    t="$(timeout 0.5 git describe --tags --abbrev=0 2>/dev/null)"
    if [[ $? -eq 124 ]]
    then
        t='git-timeout'
        ps -u "$USER" -o cmd | grep -q '[g]it describe' || { git describe --tags --abbrev=0 &>/dev/null & }
    fi
    printf "${my_pur}:${t}"
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
                    _ps1_git_branch="${my_grn2}:${h##*/}${my_rst}"
                    return 0
                    ;;
                "")
                    _ps1_git_branch=''
                    return 0
                    ;;
                *)
                    _ps1_git_branch="${my_grn2}:D:${h:0:7}$(__ps1_git_tag_f)${my_rst}"
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
    (( $le == 0 )) || ep="${my_red}:${le}${my_rst}"

    ms=$(( ($(${EXEC_DATE} +%s%N) - ${_ps1_start_timer:-}) / 1000000 ))

    case $((
        ms < 21    ? 1 :
        ms < 101   ? 2 :
        ms < 251   ? 3 :
        ms < 501   ? 4 :
        ms < 1000  ? 5 : 6)) in
        (1)   tc="${my_grn}" ;;
        (2)   tc="${my_ylw}" ;;
        (3)   tc="${my_cyn}" ;;
        (4)   tc="${my_blu}" ;;
        (5)   tc="${my_pur}" ;;
        (6|*) tc="${my_red}" ms=$((ms/1000)) ;;
    esac

    ms="$(printf '%03d' $ms)"

    # git branch/tag
    __ps1_git_branch_f

    # background jobs
    __ps1_jobs_f

    [[ -w "${PWD}" ]] && wdc="${my_cyn}" || wdc="${my_red2}"
    [[ -z "$SSH_CLIENT" ]] || onssh="${my_ylw2}\h:${my_rst}"
    [[ -z "$IN_NIX_SHELL" ]] || onnixshell="${my_red2}(${name})${my_rst} "

    #PS1="\n\[\033]0;\u@\h:\w\007\]${tc}${ms}${my_rst} ${onssh}${wdc}\w${_ps1_git_branch}${my_rst}${_ps1_jobs}${ep} ${onnixshell}${my_blu}❯${my_rst} "
    PS1="\n\[\033]0;\u@\h:\w\007\]${tc}${ms}${my_rst} ${onssh}${wdc}\w${_ps1_git_branch}${my_rst}${_ps1_jobs}${ep} ${onnixshell}${my_blu}\$${my_rst} "

    unset _ps1_start_timer
}

trap ': "${_ps1_start_timer:=$($EXEC_DATE +%s%N)}"' DEBUG
PROMPT_COMMAND='__prompt_command'
