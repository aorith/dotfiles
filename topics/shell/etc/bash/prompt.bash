# vim: ft=bash

__git_tag() {
    local __dir __tag
    __dir="$1"
    if [ -e "$__dir/.git/refs/heads/master" ]; then
        if [ -e "$__dir/.git/refs/tags" ]; then
            __commit="$(cat "$__dir/.git/refs/heads/master")"
            __tag="$(grep -rl "$__commit" "$__dir/.git/refs/tags")"
            [[ -z "$__tag" ]] && return 0
            echo " (tag ${__tag##*/})"
        fi
    fi
}

__git_ps1() {
    local __dir __head
    __dir="$(pwd -P)"
    _BRANCH=""
    while [ -n "$__dir" ]; do
        if [ -e "$__dir/.git/HEAD" ]; then
            read -r __head < "$__dir/.git/HEAD"
            case "$__head" in
                ref:*)
                    _BRANCH="\[${my_grnE}\](${__head##*/})\[${my_pur}\]$(__git_tag "$__dir")\[${my_rst}\] "
                    return 0
                    ;;
                "")
                    _BRANCH=""
                    return 0
                    ;;
                *)
                    _BRANCH="\[${my_pur2}\](Detached: ${__head:0:7})\[${my_pur}\]$(__git_tag "$__dir")\[${my_rst}\] "
                    return 0
                    ;;
            esac
        fi
        __dir="${__dir%/*}"
    done
}

__jobs_ps1() {
    local _jobs _rjobs
    _JOBS=""
    _jobs=( $(jobs -p) )
    [[ -z "${_jobs[*]}" ]] && return 0

    _rjobs=( $(jobs -rp) )
    _JOBS="\[${my_ylwE}\](Jobs: ${#_rjobs[@]}/${#_jobs[@]})\[${my_rst}\] "
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

    _TIMER_VAL="\[${my_gry}\]~${_timer_val}\[${my_rst}\] "
    unset _TIMER
    unset timer_now
}

__prompt_command () {
    __last_exit=$?
    local LANG=C _WDCOLOR _ERRPROMPT
    [ $__last_exit -ne 0 ] && _ERRPROMPT="\[${my_red}${my_bld}\]${__last_exit}\[${my_rst}\] "

    # timer
    #__stop_timer

    # mostramos rama si es un repo git
    __git_ps1

    # mostramos jobs en background
    __jobs_ps1

    [ -w $PWD ] && _WDCOLOR="\[\${my_cynE}\]" || _WDCOLOR="\[${my_red}\]"
    [[ -n "$SSH_CLIENT" ]] && _ON_SSH="\[${my_bld}${my_ylw2}\]ssh\[${my_rst}\]@"

    PS1="${_ON_SSH}\[\${my_orgE}\]\u\[${my_rst}\]@\
\[${my_bld}${my_org2E}\]\h\[${my_rst}\] ${_WDCOLOR}\w\[${my_rst}\] \
${_BRANCH}${_LOADAVG}${_JOBS}${_ERRPROMPT}\[${my_rst}\]\
\[${my_blu2E}\]"$'\u276F\[\033[0m\] '
    export PS1

    #unset _TIMER_IS_SET
}

export PS4='+ ${BASH_SOURCE}:${LINENO}: ${FUNCNAME[0]}() [$?] → '

