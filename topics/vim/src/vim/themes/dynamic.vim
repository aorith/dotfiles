" Change the theme with <F1>
" Theme definitions are stored in ~/.local/share/vim/light_theme
" and in ~/.local/share/vim/dark_theme

" Defaults
let my_dark_theme = "tempus_winter"
let my_light_theme = "tempus_day"

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

function! ToggleBackground()
  if $USER == "root"
    echo "Not available as root."
    return
  endif
  if filereadable($HOME . '/.local/share/vim/darkmode')
    call system('rm -f ~/.local/share/vim/darkmode')
    execute "colorscheme " . g:my_light_theme
  else
    call system('touch ~/.local/share/vim/darkmode')
    execute "colorscheme " . g:my_dark_theme
  endif
endfunction
map <F1> :call ToggleBackground()<CR>
map! <F1> :call ToggleBackground()<CR>

" Initial config when vim opens
let g:tempus_enforce_background_color=1
if filereadable($HOME . '/.local/share/vim/darkmode')
  execute "colorscheme " . my_dark_theme
else
  execute "colorscheme " . my_light_theme
endif
