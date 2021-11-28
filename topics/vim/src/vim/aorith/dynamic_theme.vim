" Change the theme with <F1>
" Theme definitions are stored in ~/.local/share/vim/light_theme
" and in ~/.local/share/vim/dark_theme

if exists('g:loaded_my_theme')
  finish
end
let g:loaded_my_theme = '1'

" Helper for 'change_vim_theme'
function MySaveColorSchemes()
  execute ':e /tmp/.vim-themes.txt'
  execute ':normal ggdG'
  let l:files = globpath(&rtp, 'colors/*.vim', 0, 1)
  for file in l:files
    if file =~ $HOME
      put=file
    endif
  endfor
  execute ':wq!'
endfunction

" Defaults
set termguicolors
let my_dark_theme = "apprentice"
let my_light_theme = "gruvbox"
let g:gruvbox_undercurl = 0
let g:gruvbox_invert_selection = 0
let g:gruvbox_italicize_strings = 0
"let g:gruvbox_guisp_fallback = 'fg'


if filereadable($HOME . '/.local/share/vim/transparent_bg')
  let g:PaperColor_Theme_Options = {
        \ 'theme': { 'default': {
          \ 'transparent_background': 1 } }
        \ }
  let g:everforest_transparent_background = 1
endif

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

function MyThemeToggle()
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
map <F1> <Nop>
map! <silent> <F1> <Nop>
nnoremap <silent> <F1> :call MyThemeToggle()<CR>

" Initial config when vim opens
if filereadable($HOME . '/.local/share/vim/darkmode')
  set bg=dark
  execute "silent! colorscheme " . my_dark_theme
else
  set bg=light
  execute "silent! colorscheme " . my_light_theme
endif

" Theme overrides
if filereadable($HOME . '/.local/share/vim/transparent_bg')
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NonText guibg=NONE ctermbg=NONE
  highlight LineNr guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
  highlight TabLineFill guibg=NONE ctermbg=NONE
endif
highlight SpellBad ctermbg=234 ctermfg=darkred cterm=NONE
highlight SpellRare ctermbg=234 ctermfg=darkred cterm=NONE
