# vim: ft=zsh

# set cmd_start earlier
_cmd_start=$(print -P %D{%s%6.})

# Allow for variable/function substitution in prompt
setopt prompt_subst

function _my_preexec () {
    print -Pn -- '\e]2;%m:%. %# ' && print -n -- "${(q)1}\a"
    _cmd_start=$(print -P %D{%s%6.})
}

function _my_precmd () {
    print -Pn -- '\e]2;%m:%.\a'

    # elapsed cmd time
    local now=$(print -P %D{%s%6.})
    local delta_us=$(( now - _cmd_start ))
    local us=$((delta_us % 1000))
    local ms=$(((delta_us / 1000) % 1000))
    local s=$(((delta_us / 1000000) % 60))
    local m=$(((delta_us / 60000000) % 60))
    local h=$((delta_us / 3600000000))
    if ((h > 0)); then _cmd_time="~${h}h${m}m "
    elif ((m > 0)); then _cmd_time="~${m}m${s}s "
    elif ((s >= 10)); then _cmd_time="~${s}.$((ms / 100))s "
    elif ((s > 0)); then _cmd_time="~${s}.$(printf %03d $ms)s "
    elif ((ms >= 100)); then _cmd_time="~${ms}ms "
    elif ((ms > 0)); then _cmd_time="~${ms}.$((delta_us / 100))ms "
    else _cmd_time="~${delta_us}us "
    fi
}

_my_git_tag_cmd() {
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

_my_git_precmd() {
    local head
    local dir="$(pwd -P)"

    _BRANCH=""
    while [ -n "$dir" ]; do
        if [ -e "$dir/.git/HEAD" ]; then
            read -r head < "$dir/.git/HEAD"
            case "$head" in
                ref:*)
                    _BRANCH="%b%F{34}(${head##*/})%F{91}$(_my_git_tag_cmd "$dir")%f%b "
                    return 0
                    ;;
                "")
                    _BRANCH=""
                    return 0
                    ;;
                *)
                    _BRANCH="%F{154}%b(Detached: ${head:0:7})%F{91}$(_my_git_tag_cmd "$dir")%f%b "
                    return 0
                    ;;
            esac
        fi
        dir="${dir%/*}"
    done
}

add-zsh-hook -Uz preexec _my_preexec
add-zsh-hook -Uz precmd _my_precmd
add-zsh-hook -Uz precmd _my_git_precmd

function PCMD() {
    [[ -n "$SSH_CLIENT" ]] && _on_ssh="@%F{229}ssh%f" || _on_ssh=""
    echo "%F{208}%n%f@%F{202}%B%m%f%b$_on_ssh %F{109}%~%f %F{241}$_cmd_time%f$_BRANCH%(1j.%F{144}[Jobs:%j]%f .)%(?..%F{196}%B%?%f%b ) \n%F{239}%* %F{69}\u276F%f%b "
}

PROMPT='$(PCMD)'
