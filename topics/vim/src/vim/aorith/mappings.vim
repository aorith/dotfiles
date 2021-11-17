if !exists('*MyThemeToggle') " if this function does not exist...
  map <F1> <Nop>
  map! <F1> <Nop>
end

" Disable current search highlighting with Ctrl-l
nnoremap <silent> <C-l> :nohl<CR>

" Alternate between previous file with Backspace
nnoremap <silent> <BS> :e#<CR>

" Use C-W + hjkl instead
"nnoremap <leader>h :wincmd h<CR>
"nnoremap <leader>j :wincmd j<CR>
"nnoremap <leader>k :wincmd k<CR>
"nnoremap <leader>l :wincmd l<CR>

" Copy to system clipboard using osc52
nnoremap <leader>y V:OSCYank<CR>
vnoremap <leader>y :OSCYank<CR>

" bnext = next buffer
nnoremap <leader><TAB> :bnext<CR>

" Make :Q and :W work like :q and :w
command! W w
command! Q q

" netrw
let g:netrw_banner = 1
let g:netrw_liststyle = 1
let g:netrw_altv = 1
let g:netrw_browse_split = 0
let g:netrw_winsize = 40
let g:netrw_browsex_viewer = '-'
function NetrwToggler()
    if &filetype == "netrw"
      silent execute ":bd"
    else
      silent execute ":Explore"
    endif
endfunction
noremap <silent> <leader>e <Esc><Esc>:call NetrwToggler()<CR>

" Pastetoggle
set pastetoggle=<F2>

" List toggle (:h map-modes)
map <silent> <F3> <Esc><Esc>:set list!<CR>
map! <silent> <F3> <Esc><Esc>:set list!<CR>

" autoload/mygit.vim ---------------------------------
" Show in a terminal the commit that introduced current(selected) line
" pass a number for the history: eg '5<Leader>g'
"noremap <Leader>g :call mygit#show_commit(v:count)<CR>
" Show git blame for the line (or selection) in a popup
"noremap <Leader>gb :call mygit#blame_popup()<CR>

" --- PLUGINS -----------------------------------------------------------------

" ALE
nnoremap <leader>ld :ALEGoToDefinition<CR>
nnoremap <leader>ll :ALEHover<CR>
nnoremap <leader>lr :ALEFindReferences<CR>

" VIM-FUGITIVE
noremap <leader>gb :Git blame<CR>

" VIM-SIGNIFY
nnoremap <leader>gd :SignifyDiff<CR>:wincmd h<CR>

" FZF
nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>fgf :GFiles<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>fl :Lines<CR>

" VIM-WIKI
nnoremap <leader><space> :VimwikiToggleListItem<CR>
