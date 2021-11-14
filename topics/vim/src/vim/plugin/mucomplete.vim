set complete-=t " don't scan tags by default

set completeopt+=menuone
set completeopt+=noselect " prefer it over 'noinsert'
set completeopt-=preview
set completeopt+=popup

let g:mucomplete#enable_auto_at_startup = 1
let g:mucomplete#completion_delay = 100
let g:mucomplete#reopen_immediately = 0

" Disable <tab> completion
"imap <c-n> <plug>(MUcompleteFwd)
"imap <c-p> <plug>(MUcompleteBwd)

" Tip:
" - you can insert a tab using '<C-Q><TAB>' or '<C-V><TAB>' in insert mode
