" vim: ft=vim
function! MyHighlights() abort
    if ! has('gui_running')
        highlight Normal cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE gui=NONE
    endif
endfunction

"augroup MyColors
"    autocmd!
"    autocmd ColorScheme * call MyHighlights()
"augroup end

colorscheme apprentice
