" yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

"markdown
" no ocultes los backticks (a causa de indentLine)
autocmd FileType markdown let g:indentLine_setConceal = 0

" python
" select lines + gq
" full document with gggqG
autocmd FileType python setlocal formatprg=autopep8\ -

