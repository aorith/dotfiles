" highlight non ascii characters
highlight NonAscii guibg=Red ctermbg=2

" highlight extra whitespace
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen

augroup aorith_autocmds
    autocmd!
    " highlight non ascii characters
    autocmd BufRead * syntax match NonAscii "[^\x00-\x7F]" containedin=all
    " highlight extra whitespace
    autocmd BufRead * syntax match ExtraWhitespace /\s\+$/ containedin=all
    " Last position without centered cursor
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
    " For large files
    autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax sync clear | endif
augroup END

" highlight current line
set cursorline
if exists('+cursorlineopt')
    set cursorlineopt=number
endif

" use % to jump from if to endif for example
runtime macros/matchit.vim
" Load manpages on vim using :Man <whatever>
runtime ftplugin/man.vim

" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
