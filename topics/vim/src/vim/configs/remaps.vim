" Remaps
let mapleader = "\<Space>"
nnoremap <Space> <Nop>

" Disable current search highlighting with Ctrl-L
nnoremap <C-L> :nohl<CR><C-L>

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Copy to system clipboard using osc52
nnoremap <leader>y V:OSCYank<CR>
vnoremap <leader>y :OSCYank<CR>

" Permite moverte con TAB (en normal mode) de un [ ..... a otro ]
nnoremap <TAB> %

" bnext = next buffer
nnoremap <leader><TAB> :bnext<CR>

" funcion para comparar ficheros
function! s:DiffOrig(mySplit)
  let filetype=&ft
  diffthis

  if a:mySplit == "h"
      new | r # | normal! 1Gdd
  else
      vnew | r # | normal! 1Gdd
  endif

  diffthis
  exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
endfunction
command! -nargs=1 DiffOrig call s:DiffOrig(<f-args>)

" Para comparar ficheros, usa :diffsplit <file>
" y para ver que cambiaste en el actual, este atajo:
nnoremap <leader>d :DiffOrig v<CR>
" lo mismo pero horizontal
nnoremap <leader>D :DiffOrig h<CR>

" Make :Q and :W work like :q and :w
command! W w
command! Q q

" netrw working like nerdtree
let g:netrw_banner = 1
let g:netrw_liststyle = 1
let g:netrw_browse_split = 3
let g:netrw_altv = 1
let g:netrw_winsize = 40
nmap <silent> <leader>e :Lexplore<CR>

" Pastetoggle
set pastetoggle=<F2>

" List toggle (:h map-modes)
map <silent> <F3> <Esc><Esc>:set list!<CR>
map! <silent> <F3> <Esc><Esc>:set list!<CR>

" autoload/mygit.vim ---------------------------------
" Show in a terminal the commit that introduced current(selected) line
" pass a number for the history: eg '5<Leader>g'
noremap <Leader>g :call mygit#show_commit(v:count)<CR>
" Show git blame for the line (or selection) in a popup
noremap <Leader>gb :call mygit#blame_popup()<CR>
