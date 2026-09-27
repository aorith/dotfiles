# vim: ft=bash
# Sourced from: bashrc

# shellcheck disable=SC2034
my_blk=$'\e[30m'       # Black
my_red=$'\e[31m'       # Red
my_grn=$'\e[32m'       # Green
my_ylw=$'\e[33m'       # Yellow
my_blu=$'\e[34m'       # Blue
my_pur=$'\e[35m'       # Purple
my_cyn=$'\e[36m'       # Cyan
my_whi=$'\e[37m'       # White
my_gry=$'\e[90m'       # Grey (bright black)
my_red2=$'\e[91m'      # Bright red
my_grn2=$'\e[92m'      # Bright green
my_ylw2=$'\e[93m'      # Bright yellow
my_blu2=$'\e[94m'      # Bright blue
my_pur2=$'\e[95m'      # Bright purple
my_cyn2=$'\e[96m'      # Bright cyan
my_whi2=$'\e[97m'      # Bright white
my_blk2=$'\e[38;5;16m' # Black (256-color palette #16)
my_bld=$'\e[1m'        # Bold
my_und=$'\e[4m'        # Underline
my_rvs=$'\e[7m'        # Reverse
my_rst=$'\e[0m'        # Text Reset

if command -v timeout >/dev/null; then
    __ps1_timeout=(timeout 0.1)
elif command -v gtimeout >/dev/null; then
    __ps1_timeout=(gtimeout 0.1)
else
    __ps1_timeout=()
fi

__ps1_git_info_f() {
    local d="$PWD" branch oid tag out rc l i=0
    local -a lines
    __ps1_git_info=''
    __ps1_git_dirty=''
    __ps1_git_root=''

    # Find repo root without forking git
    while [[ -n "$d" && ! -e "$d/.git" ]]; do
        d="${d%/*}"
    done
    [[ -n "$d" ]] || return

    out="$("${__ps1_timeout[@]}" git --no-optional-locks status --porcelain=v2 --branch 2>/dev/null)"
    rc=$?
    # Fails e.g. inside .git/
    ((rc == 0 || rc == 124)) || return
    __ps1_git_root="$d"

    if ((rc == 124)); then
        branch="$(git symbolic-ref --short -q HEAD)" || branch="D:$(git rev-parse --short HEAD 2>/dev/null)"
    else
        mapfile -t lines <<<"$out"
        for l in "${lines[@]}"; do
            case "$l" in
            '# branch.oid '*) oid="${l#'# branch.oid '}" ;;
            '# branch.head '*) branch="${l#'# branch.head '}" ;;
            '#'*) ;;
            *) break ;;
            esac
            ((++i))
        done
        [[ "$branch" == '(detached)' ]] && branch="D:${oid:0:7}"
    fi

    # Append tag if HEAD is exactly on one
    tag="$(git describe --tags --exact-match HEAD 2>/dev/null)"
    [[ -z "$tag" ]] || branch+=" ${tag}"

    __ps1_git_info="${branch}:"
    if ((rc == 124)); then
        __ps1_git_dirty='(timeout) '
    elif ((${#lines[@]} > i)); then
        __ps1_git_dirty="($((${#lines[@]} - i))) "
    else
        __ps1_git_info="${branch} "
    fi
}

__prompt_command() {
    local rc=$?
    # \001/\002 are what \[ \] expand to
    local s=$'\001' e=$'\002'

    __ps1_ret=''
    ((rc == 0)) || __ps1_ret="${s}${my_red}${e}(${rc})${s}${my_rst}${e} "

    __ps1_git_info_f
    __ps1_git_final="${__ps1_git_info:+${s}${my_bld}${my_grn}${e}${__ps1_git_info}${s}${my_rst}${my_gry}${e}${__ps1_git_dirty}${s}${my_rst}${e}}"

    # Red color if path is not writable
    local _path_color="$my_red2"
    [[ -w "$PWD" ]] && _path_color="$my_blu"

    # Tweak path
    local __pre_path="$PWD" __git_root_name='' __post_path=''
    if [[ -n "$__ps1_git_root" ]]; then         # /Users/aorith/githome/dotfiles
        __pre_path="${__ps1_git_root%/*}/"      # /Users/aorith/githome/
        __git_root_name="${__ps1_git_root##*/}" # dotfiles
        __post_path="${PWD#"$__ps1_git_root"}"  # /topics (if we are at /Users/aorith/githome/dotfiles/topics)
    fi

    # Use ~ for $HOME
    if [[ "$__ps1_git_root" == "$HOME" ]]; then
        __pre_path=''
        __git_root_name='~'
    elif [[ "$__pre_path" == "$HOME" || "$__pre_path" == "$HOME"/* ]]; then
        __pre_path="~${__pre_path#"$HOME"}"
    fi
    if [[ "$PWD" != "$HOME" && "$PWD" != / ]]; then
        __post_path+=/
    fi

    # Repo root in bold+underline
    __ps1_path="${s}${_path_color}${e}${__pre_path}"
    if [[ -n "$__git_root_name" ]]; then
        __ps1_path+="${s}${my_bld}${my_und}${e}${__git_root_name}${s}${my_rst}${_path_color}${e}"
    fi
    __ps1_path+="${__post_path}${s}${my_rst}${e}"

    # Print bg jobs when they exist
    local n='\j'
    n="${n@P}"
    __ps1_jobs=''
    ((n == 0)) || __ps1_jobs="${s}${my_gry}${e}[$n jobs]${s}${my_rst}${e} "

    __ps1_nix_shell="${IN_NIX_SHELL:+${s}${my_red2}${e}(${name:-unset})${s}${my_rst}${e} }"
    __ps1_venv="${VIRTUAL_ENV_PROMPT:+${s}${my_pur2}${e}venv:${VIRTUAL_ENV_PROMPT}${s}${my_rst}${e} }"
    __ps1_kube="${KUBECONFIG:+${s}${my_ylw}${e}[K:${KC_CURRENT_CONTEXT:-${KUBECONFIG##*/}}]${s}${my_rst}${e} }"
    __ps1_aws="${AWS_PROFILE:+${s}${my_pur2}${e}[A:${AWS_PROFILE}]${s}${my_rst}${e} }"
}

PS1='\n${__ps1_ret}${__ps1_jobs}'
if [[ -n "$CONTAINER_ID" ]]; then
    PS1+='\[${my_pur2}\][${CONTAINER_ID}]\[${my_rst}\] '
fi
if [[ -n "$SSH_CONNECTION" || -n "$SSH_TTY" ]]; then
    PS1+='\[\033]0;\u@\h \w\007\]\[${my_ylw2}\]\h\[${my_rst}\] '
else
    PS1+='\[\033]0;\w\007\]'
fi
PS1+='${__ps1_path} ${__ps1_git_final}'
PS1+='${__ps1_nix_shell}${__ps1_venv}'
PS1+='${__ps1_kube}${__ps1_aws}'
PS1+='\n\[${my_blu2}\]\$\[${my_rst}\] '

# Prepend so $? is still the user's and keep hooks added by others (vte, direnv, ...)
# if [[ "$PROMPT_COMMAND" != *__prompt_command* ]]; then
#     PROMPT_COMMAND="__prompt_command${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
# fi

# Or ignore hooks
PROMPT_COMMAND='__prompt_command'
