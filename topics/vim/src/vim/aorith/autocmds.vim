augroup aorith_autocmds
    autocmd!
    " Last position without centered cursor
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    " For large files
    "autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax sync clear | endif

    " pandoc
    " autocmd BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
    " theme overrides
    " autocmd FileType markdown,pandoc highlight pandocAtxHeader ctermfg=yellow ctermbg=NONE
    " autocmd FileType markdown,pandoc highlight pandocAtxStart ctermfg=yellow ctermbg=NONE
    " autocmd FileType markdown,pandoc highlight pandocNoFormatted cterm=none term=none ctermfg=Magenta

    autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO\|FIXME', -1)
augroup END
