" varnish & nginx
function! VhostFTDetect() abort
    " if the directory path contains 'varnish'
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
