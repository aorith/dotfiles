#!/usr/bin/env bash -l

export PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
printf 'Enter new title: '
read title || exit 0
[[ -n "$title" ]] || exit 0
echo -e "\x1b]1337;SetUserVar=panetitle=$(echo -n "$title" | base64)\x07" || exit 1
