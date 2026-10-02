# Copied & Modified from 'fzf --bash'

__fzf_history() {
    local output
    output=$(
        set +o pipefail
        builtin fc -lnr -2147483648 |
            last_hist=$(HISTTIMEFORMAT='' builtin history 1) command perl -n -l0 -e '
        BEGIN { getc; $/ = "\n\t"; $N = $ENV{last_hist} + 1 }
        s/^[ *]//;
        print "\e[90m" . ($N - $.) . "\e[m\t$_" if !$seen{$_}++' |
            fzf --height 40% --min-height 20+ \
                --read0 --ansi --scheme=history --highlight-line -n2.. \
                --bind=ctrl-r:toggle-sort \
                --query "$READLINE_LINE"
    )
    [[ -n $output ]] || return
    READLINE_LINE=${output#*$'\t'}
    READLINE_POINT=0x7fffffff
}

bind -x '"\C-r": __fzf_history'
