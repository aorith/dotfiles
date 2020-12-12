augroup aorith_autocmds
    autocmd!
    " highlight extra whitespace
    autocmd ColorScheme * highlight ExtraWhitespace ctermbg=54 guibg=#ff0000
    autocmd ColorScheme * match ExtraWhitespace /\s\+$/
    autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
    autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
    autocmd InsertLeave * match ExtraWhitespace /\s\+$/
    autocmd BufWinLeave * call clearmatches()
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
