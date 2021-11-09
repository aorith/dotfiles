" varnish & nginx
function! VhostFTDetect() abort
    " if the directory path contains 'varnish'
    if expand('%:p') =~? 'varnish'
        setfiletype vcl
    else
        setfiletype nginx
    endif
endfunction

augroup myauto_syntax
    autocmd!
    autocmd BufNewFile,BufRead *.vhost call VhostFTDetect()
    autocmd BufNewFile,BufRead *.vcl setfiletype vcl
    autocmd BufNewFile,BufRead known_hosts setfiletype sshknownhosts
augroup END

