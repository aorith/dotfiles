function! ToggleBackground()
  if filereadable($HOME . '/.local/share/vim/darkmode')
    call system('rm -f ~/.local/share/vim/darkmode')
    set background=light
    colorscheme tempus_day
  else
    call system('touch ~/.local/share/vim/darkmode')
    set background=dark
    colorscheme tempus_dusk
  endif
endfunction
map <F1> :call ToggleBackground()<CR>
map! <F1> :call ToggleBackground()<CR>

" Initial config when vim opens
let g:tempus_enforce_background_color=1
if filereadable($HOME . '/.local/share/vim/darkmode')
  set background=dark
  colorscheme tempus_dusk
else
  set background=light
  colorscheme tempus_day
endif
