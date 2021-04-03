function! MyHighlights() abort
    highlight Visual ctermbg=235 ctermfg=107 cterm=reverse
    highlight Pmenu ctermbg=232 ctermfg=252 cterm=NONE
    highlight PmenuSbar ctermbg=240 ctermfg=NONE cterm=NONE
    highlight PmenuSel ctermbg=66 ctermfg=235 cterm=bold
    highlight PmenuThumb ctermbg=66 ctermfg=66 cterm=NONE
endfunction

augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup end

set background=dark
colorscheme gruvbox8
