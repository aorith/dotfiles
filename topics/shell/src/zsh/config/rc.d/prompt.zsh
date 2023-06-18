# vim: ft=zsh

# prompt:
# %F => color dict
# %f => reset color
# %~ => current path
# %* => time
# %n => username
# %m => shortname host
# %(?..) => prompt conditional - %(condition.true.false)

# Allow for variable/function substitution in prompt
setopt prompt_subst

# Git
# Export messages
#   $vcs_info_msg_0_ : Normal (Green)
#   $vcs_info_msg_1_ : Warning (Yellow)
#   $vcs_info_msg_2_ : Error (Red)
zstyle ':vcs_info:*' max-exports 3
zstyle ':vcs_info:*' enable git
# show whether staged or not.
zstyle ':vcs_info:git:*' formats '[%b]' '%c%u %m'
zstyle ':vcs_info:git:*' actionformats '[%b]' '%c%u %m' '<!%a>'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "+"    # string for %c
zstyle ':vcs_info:git:*' unstagedstr "-"  # string for %u

# Git hooks
# formats '(%s)-[%b]' '%c%u %m' , actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
# hook before the message above
# In this configuration, available messages is 2 for 'format' , 3 for 'actionformats',
# so each functions are called 3 times at maximum.
zstyle ':vcs_info:git+set-message:*' hooks \
                                        git-hook-begin \
                                        git-untracked \
                                        git-push-status \
                                        git-nomerge-branch \
                                        git-stash-count

# First hook function
# hooks functions are called if there are working copy of git (not in .git directory)
# because, for example, `git status --porcelain` will be failed, in .git directory.
function +vi-git-hook-begin() {
    if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
        # hook functions after this will not be called if not 0 is returned.
        return 1
    fi

    return 0
}

# Showing untracked files
#
# Append '?' to `unstaged (%u)` if there are any untracked files.
function +vi-git-untracked() {
    # targets 2nd message in zstyle formats, actionformats
    if [[ "$1" != "1" ]]; then
        return 0
    fi

    if command git status --porcelain 2> /dev/null \
        | awk '{print $1}' \
        | command grep -F '??' > /dev/null 2>&1 ; then

        # Append to unstaged (%u)
        hook_com[unstaged]+='?'
    fi
}

# Showing number of commits that aren't pushed yet.
#
# Append 'pN', N is a number of un-pushed commits, to `misc (%m)`
function +vi-git-push-status() {
    # targets 2nd message in zstyle formats, actionformats
    if [[ "$1" != "1" ]]; then
        return 0
    fi

    if [[ "${hook_com[branch]}" != "master" ]]; then
        # Do nothing if it is not master branch
        return 0
    fi

    # get number of commits that un-pushed
    local ahead
    ahead=$(command git rev-list origin/master..master 2>/dev/null \
        | wc -l \
        | tr -d ' ')

    if [[ "$ahead" -gt 0 ]]; then
        # Append to misc (%m)
        hook_com[misc]+="(p${ahead})"
    fi
}

# Show unmerged commits
#
# Show mN in misc (%m). N is number of commits in current branch that is not merged to master.
function +vi-git-nomerge-branch() {
    # targets 2nd message in zstyle formats, actionformats
    if [[ "$1" != "1" ]]; then
        return 0
    fi

    if [[ "${hook_com[branch]}" == "master" ]]; then
        # Do nothing if it is master branch
        return 0
    fi

    local nomerged
    nomerged=$(command git rev-list master..${hook_com[branch]} 2>/dev/null | wc -l | tr -d ' ')

    if [[ "$nomerged" -gt 0 ]] ; then
        # Append to misc (%m)
        hook_com[misc]+="(m${nomerged})"
    fi
}


# Show stashes
#
# Show :SN in misc (%m). N is a number of stashes
function +vi-git-stash-count() {
    # targets 2nd message in zstyle formats, actionformats
    if [[ "$1" != "1" ]]; then
        return 0
    fi

    local stash
    stash=$(command git stash list 2>/dev/null | wc -l | tr -d ' ')
    if [[ "${stash}" -gt 0 ]]; then
        # Append to misc (%m)
        hook_com[misc]+=":S${stash}"
    fi
}

function _preexec_cmd_start () {
    print -Pn -- '\e]2;%m:%. %# ' && print -n -- "${(q)1}\a"
    _cmd_start=$(print -P %D{%s%6.})
}

function precmd () {
    # git info
    vcs_info

    print -Pn -- '\e]2;%m:%.\a'
    # elapsed cmd time
    local now=$(print -P %D{%s%6.})
    local delta_us=$(( now - _cmd_start ))
    local us=$((delta_us % 1000))
    local ms=$(((delta_us / 1000) % 1000))
    local s=$(((delta_us / 1000000) % 60))
    local m=$(((delta_us / 60000000) % 60))
    local h=$((delta_us / 3600000000))
    if ((h > 0)); then _cmd_time="${h}h${m}m "
    elif ((m > 0)); then _cmd_time="${m}m${s}s "
    elif ((s >= 10)); then _cmd_time="${s}.$((ms / 100))s "
    elif ((s > 0)); then _cmd_time="${s}.$(printf %03d $ms)s "
    elif ((ms >= 100)); then _cmd_time="${ms}ms "
    elif ((ms > 0)); then _cmd_time="${ms}.$((delta_us / 100))ms "
    else _cmd_time="${delta_us}us "
    fi
}

function prompt_cmd() {
    local -a messages
    local _on_ssh
    local _vcs_info

    if [[ -z ${vcs_info_msg_0_} ]]; then
        _vcs_info=""
    else
        [[ -n "$vcs_info_msg_0_" ]] && messages+=( "%F{green}${vcs_info_msg_0_}%f" )
        [[ -n "$vcs_info_msg_1_" ]] && messages+=( "%F{yellow}${vcs_info_msg_1_}%f" )
        [[ -n "$vcs_info_msg_2_" ]] && messages+=( "%F{red}${vcs_info_msg_2_}%f" )

        # concatenate them separated with space
        _vcs_info="${(j: :)messages}"
    fi

    [[ -z "$SSH_CLIENT" ]] || _on_ssh="%F{229}%Bssh%f%b@"
    echo "$_on_ssh%F{208}%n%f@%F{202}%B%m%f%b %F{109}%~%f %F{241}$_cmd_time%f$_vcs_info%(1j.%F{144}[Jobs:%j]%f .)%(?..%F{196}%B%?%f%b) \n%F{239}%T %F{69}\u276F%f%b "
}

# Autoloads
autoload -Uz vcs_info
autoload -Uz add-zsh-hook

add-zsh-hook -Uz preexec _preexec_cmd_start

# set cmd_start earlier
_cmd_start=$(print -P %D{%s%6.})

PROMPT='$(prompt_cmd)'
