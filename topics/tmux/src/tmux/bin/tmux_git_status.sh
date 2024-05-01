#!/usr/bin/env bash

# $1 = current path
# $2 = pane is active
# $3 = current command

[[ "$2" == "1" ]] || exit
[[ ! "$3" =~ ^ssh|docker|podman ]] || exit
cd "$1" || exit 1

my_rst="#[default]"
my_bld="#[bold]"
my_gry="#[fg=gray]"
my_grn2="#[fg=lightgreen]"
my_blu2="#[fg=blue]"

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    exit
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
status="$(git status --short --untracked-files=all --porcelain | awk '{ count[$1]++; } END { out=""; for (s in count) { if (out != "") { out = out " "; } out = out s ":" count[s]; } print out; }')"
if [[ -n "$status" ]]; then
    branch="${branch} ${my_rst}${my_gry}($status)"
fi

#echo -n "=[${my_grn2}${branch}${my_rst}]"
echo -n "${my_grn2}${branch}${my_rst}"
