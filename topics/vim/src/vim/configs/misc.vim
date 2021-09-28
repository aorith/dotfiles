" vim: ft=vim

" Highligh extra whitespace
match ErrorMsg '\s\+$'

augroup aorith_autocmds
    autocmd!
    " Last position without centered cursor
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    " For large files
    "autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax sync clear | endif
augroup end

" highlight current line
set cursorline
if exists('+cursorlineopt')
    set cursorlineopt=number
endif

" use % to jump from if to endif for example
runtime macros/matchit.vim

