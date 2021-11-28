if !exists('*MyThemeToggle') " if this function does not exist...
  map <F1> <Nop>
  map! <F1> <Nop>
end

" I don't want to enter Ex mode
nnoremap Q <Nop>

" Search results in the middle
nnoremap n nzz
nnoremap N Nzz

" Disable current search highlighting with Ctrl-l
nnoremap <silent> <leader>/ :nohl<CR>

" Alternate between previous file with Backspace
nnoremap <silent> <BS> :e#<CR>

" Navigate windows
nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l
" same but Visual/select mode
xnoremap <C-h> <C-W>h
xnoremap <C-j> <C-W>j
xnoremap <C-k> <C-W>k
xnoremap <C-l> <C-W>l

" Copy to system clipboard using osc52 (current line)
nnoremap <silent> <leader>y :.w !osccopy<CR>
" (selection)
xnoremap <silent> <leader>y :w !osccopy<CR>

" bnext = next buffer
nnoremap <leader><TAB> :bnext<CR>

" Make :Q and :W work like :q and :w
command! W w
command! Q q

" --- NetRW {{{ ---
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
" --- }}} ---

" --- {{{ F-Keys toggles ---
" Pastetoggle
set pastetoggle=<F2>

" List toggle (:h map-modes)
map <silent> <F3> <Esc><Esc>:set list!<CR>
map! <silent> <F3> <Esc><Esc>:set list!<CR>
" --- }}} ---

" --- PLUGINS {{{ ---

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
nnoremap <silent> <leader>fg :Rg<CR>
nnoremap <silent> <leader>fgf :GFiles<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>fl :Lines<CR>

" --- }}} ---
