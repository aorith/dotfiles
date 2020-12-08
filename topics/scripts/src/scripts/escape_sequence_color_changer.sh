#!/usr/bin/env bash

term_scheme() {
    local COLOR="$1"
    if [ "$TERM" == "tmux-256color" ]; then
        # TMUX
        echo -ne "\\ePtmux;\\e\\033]11;$COLOR\\007\\e\\\\"
    else
        #  NOT TMUX
        echo -ne "\\033]11;$COLOR\\007"
    fi
}

if [[ $# -ne 1 ]]; then
    echo "Pass a color to change the background, ex: #131313"
    exit 1
fi

term_scheme $1

