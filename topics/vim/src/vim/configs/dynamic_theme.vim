" Change the theme with <F1>
" Theme definitions are stored in ~/.local/share/vim/light_theme
" and in ~/.local/share/vim/dark_theme

" Theme Overrides
function! MyHighlights() abort
    highlight Normal guibg=NONE ctermbg=NONE
    highlight NonText guibg=NONE ctermbg=NONE
endfunction
"augroup MyColors
"    autocmd!
"    autocmd ColorScheme * call MyHighlights()
"augroup END

" Defaults
set termguicolors
let my_dark_theme = "apprentice"
let my_light_theme = "tempus_day"
let g:tempus_enforce_background_color=1

" Get current values for dark and light theme
" light
let my_themepath = $HOME . '/.local/share/vim/light_theme'
if filereadable(my_themepath)
  for line in readfile(my_themepath)
    let my_light_theme = line
    break
  endfor
else
  silent execute "!echo " . my_light_theme . " > " . my_themepath
endif
" dark
let my_themepath = $HOME . '/.local/share/vim/dark_theme'
if filereadable(my_themepath)
  for line in readfile(my_themepath)
    let my_dark_theme = line
    break
  endfor
else
  silent execute "!echo " . my_dark_theme . " > " . my_themepath
endif
unlet my_themepath

function! MyThemeToggle()
  if $USER == "root"
    echoerr "  Not available as root."
    return
  endif
  if filereadable($HOME . '/.local/share/vim/darkmode')
    call system('rm -f ~/.local/share/vim/darkmode')
    set bg=light
    syntax enable
    silent! execute "silent! colorscheme " . g:my_light_theme
    echomsg g:my_light_theme
  else
    call system('touch ~/.local/share/vim/darkmode')
    set bg=dark
    syntax enable
    silent! execute "silent! colorscheme " . g:my_dark_theme
    echomsg g:my_dark_theme
  endif
endfunction
map <silent> <F1> :call MyThemeToggle()<CR>
map! <silent> <F1> :call MyThemeToggle()<CR>

" Initial config when vim opens
let g:tempus_enforce_background_color=1
if filereadable($HOME . '/.local/share/vim/darkmode')
  set bg=dark
  execute "silent! colorscheme " . my_dark_theme
else
  set bg=light
  execute "silent! colorscheme " . my_light_theme
endif
