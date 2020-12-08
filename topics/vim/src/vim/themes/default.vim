" vim: ft=vim
function! MyHighlights() abort
    if ! has('gui_running')
        highlight Pmenu ctermbg=238 ctermfg=250 cterm=NONE
        highlight PmenuSbar ctermbg=240 ctermfg=NONE cterm=NONE
        highlight PmenuSel ctermbg=66 ctermfg=235 cterm=NONE
        highlight PmenuThumb ctermbg=66 ctermfg=66 cterm=NONE

        highlight SignColumn ctermbg=NONE ctermfg=lightgrey cterm=NONE

        highlight LineNr ctermbg=NONE ctermfg=240 cterm=NONE
        highlight CursorLine ctermbg=darkgrey ctermfg=NONE cterm=NONE
        highlight CursorLineNr ctermbg=NONE ctermfg=244 cterm=NONE

        highlight TabLine ctermbg=234 ctermfg=246 cterm=NONE
        highlight TabLineFill ctermbg=234 ctermfg=249 cterm=NONE
        highlight TabLineSel ctermbg=232 ctermfg=121 cterm=bold

        highlight Comment ctermbg=NONE ctermfg=240 cterm=NONE guibg=NONE guifg=#585858 gui=NONE
        highlight Visual ctermbg=24 ctermfg=250 cterm=NONE
        highlight Error ctermbg=1 ctermfg=8 cterm=bold

        highlight Normal cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE gui=NONE
        let s:fg = '#bfb0a0'
        let s:bg = '#171717'
        call SetVimFGBG("#bfb0a0", "#171717")
    endif
endfunction

augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup end

set background=dark
colorscheme default

