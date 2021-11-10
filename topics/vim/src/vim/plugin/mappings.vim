if !exists('*MyThemeToggle') " if this function does not exist...
  map <F1> <Nop>
  map! <F1> <Nop>
end

" Disable current search highlighting with Ctrl-L
nnoremap <silent> <C-L> :nohl<CR><C-L>

" Alternate between previous file with Backspace
nnoremap <silent> <BS> :e#<CR>

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

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

" FZF
nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>fgf :GFiles<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>fl :Lines<CR>
