" varnish
au BufNewFile,BufRead *.vhost setfiletype vcl
au BufNewFile,BufRead *.vcl setfiletype vcl

" known_hosts
au BufNewFile,BufRead known_hosts setfiletype sshknownhosts
