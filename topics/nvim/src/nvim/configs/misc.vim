" vim: ft=vim

augroup aorith_autocmds
    autocmd!
    " highlight extra whitespace
    autocmd ColorScheme * silent! highlight ExtraWhitespace ctermbg=54 guibg=#ff0000
    autocmd ColorScheme * silent! match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * silent! match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * silent! match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * silent! match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * silent! call clearmatches()
    " Last position without centered cursor
    autocmd BufReadPost * silent! if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    " For large files
    "autocmd BufWinEnter * silent! if line2byte(line("$") + 1) > 1000000 | syntax sync clear | endif
augroup end
" Clean the highlighted whitespace
nnoremap <leader><space> :call clearmatches()<CR>

" highlight current line
set nocursorline
if exists('+cursorlineopt')
    set cursorlineopt=number
endif

" use % to jump from if to endif for example
runtime macros/matchit.vim
