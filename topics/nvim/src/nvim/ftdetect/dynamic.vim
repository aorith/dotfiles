" varnish & nginx
function! VhostFTDetect() abort
    if expand('%:p') =~? 'varnish'
        setfiletype vcl
    else
        setfiletype nginx
    endif
endfunction
autocmd BufNewFile,BufRead *.vhost call VhostFTDetect()
autocmd BufNewFile,BufRead *.vcl setfiletype vcl

" known_hosts
autocmd BufNewFile,BufRead known_hosts setfiletype sshknownhosts

" no ocultes los backticks (a causa de indentLine)
autocmd FileType markdown let g:indentLine_setConceal = 0
