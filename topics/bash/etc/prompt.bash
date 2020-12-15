# vim: ft=bash

if [[ "$_OS" = "Darwin" ]]; then
    _AVGEXEC="sysctl -n vm.loadavg"
else
    _AVGEXEC="cat /proc/loadavg"
fi

__git_tag() {
    local dir commit tag
    dir="$1"
    if [ -e "$dir/.git/refs/heads/master" ]; then
        if [ -e "$dir/.git/refs/tags" ]; then
            commit="$(cat "$dir/.git/refs/heads/master")"
            tag="$(grep -rl "$commit" "$dir/.git/refs/tags")"
            [[ -z "$tag" ]] && return 0
            echo " (tag ${tag##*/})"
        fi
    fi
}

__git_ps1() {
    local head
    local dir="$(pwd -P)"

    _BRANCH=""
    while [ -n "$dir" ]; do
        if [ -e "$dir/.git/HEAD" ]; then
            read -r head < "$dir/.git/HEAD"
            case "$head" in
                ref:*)
                    _BRANCH="${my_bld}${my_grn}(${head##*/})${my_pur}$(__git_tag "$dir")${my_rst} "
                    return 0
                    ;;
                "")
                    _BRANCH=""
                    return 0
                    ;;
                *)
                    _BRANCH="${my_dim}${my_bld}${my_ylw}(Detached: ${head:0:7})${my_pur}$(__git_tag "$dir")${my_rst} "
                    return 0
                    ;;
            esac
        fi
        dir="${dir%/*}"
    done
}

__jobs_ps1() {
    local _jobs _rjobs
    _JOBS=""
    _jobs=( $(jobs -p) )
    [[ -z "${_jobs[*]}" ]] && return 0

    _rjobs=( $(jobs -rp) )
    _JOBS="${my_ylw}(Jobs: ${#_rjobs[@]}/${#_jobs[@]})${my_rst} "
}

__load_avg() {
    # loadavg
    local i=1 line
    [[ "$_OSTYPE" = "Darwin" ]] && i=0
    for line in $($_AVGEXEC); do
        _loadval[$i]=$line
        i=$(( i + 1 ))
    done

    _currload=0
    if _greater_than "${_loadval[1]}" "${_loadval[2]}"; then _currload=$(( _currload + 1 )); fi
    if _greater_than "${_loadval[1]}" "${_loadval[3]}"; then _currload=$(( _currload + 1 )); fi
    case $_currload in
        0) _LOADAVG="${my_grn}${_loadval[1]}↓${my_rst}" ;;
        1) _LOADAVG="${my_ylw}${_loadval[1]}↔${my_rst}" ;;
        2) _LOADAVG="${my_red}${_loadval[1]}↑${my_rst}" ;;
        *) _LOADAVG=" error " ;;
    esac
    _LOADAVG="$_LOADAVG "
}

__before_command() {
    [[ -n $_TIMER_IS_SET ]] && return 0
    _TIMER_IS_SET="yes"
    _TIMER="$(printf "%s" "${EPOCHREALTIME/.}")"
}

__stop_timer() {
    local delta_us us ms s m h _timer_val timer_now
    timer_now=$(printf "%s" "${EPOCHREALTIME/.}")

    delta_us=$(( (timer_now - _TIMER) ))
    us=$((delta_us % 1000))
    ms=$(((delta_us / 1000) % 1000))
    s=$(((delta_us / 1000000) % 60))
    m=$(((delta_us / 60000000) % 60))
    h=$((delta_us / 3600000000))
    if ((h > 0)); then _timer_val="${h}h${m}m"
    elif ((m > 0)); then _timer_val="${m}m${s}s"
    elif ((s >= 10)); then _timer_val="${s}.$((ms / 100))s"
    elif ((s > 0)); then _timer_val="${s}.$(printf %03d $ms)s"
    elif ((ms >= 100)); then _timer_val="${ms}ms"
    elif ((ms > 0)); then _timer_val="${ms}.$((delta_us / 100))ms"
    else _timer_val="${delta_us}us"
    fi

    _TIMER_VAL="${my_dim}${my_wht}~${_timer_val}${my_rst} "
    unset _TIMER
    unset timer_now
}

__prompt_command () {
    EXIT="$?"
    local LANG=C _ERRPROMPT

    history -a

    # timer
    __stop_timer

    if [ $EXIT -ne 0 ]; then
        _ERRPROMPT="${my_red}${my_bld}${EXIT}${my_rst} "
    fi

    # mostramos rama si es un repo git
    __git_ps1

    # mostramos jobs en background
    __jobs_ps1

    # load average
    #__load_avg

    [[ ! -w $PWD ]] && local _WRITEABLE="${my_red}[ro]${my_rst} "

    local _TIME
    _TIME="${my_dim}${my_wht}\t${my_rst} "

    PS1="\[\033]0;\h:\W\007\]\
${my_ylw}\u${my_rst}\
@\
${my_bld}${my_pur}\h${my_rst}\
 ${my_bld}${my_blu}\w${my_rst} \
${_BRANCH}${_WRITEABLE}${_TIME}${_TIMER_VAL}${_LOADAVG}${_JOBS}${_ERRPROMPT}${my_rst}\
 \n$ "
    export PS1

    unset _TIMER_IS_SET
}

export PS4='+ ${BASH_SOURCE}:${LINENO}: ${FUNCNAME[0]}() [$?] → '

