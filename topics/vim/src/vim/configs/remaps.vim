" Remaps
let mapleader = "\<Space>"
nnoremap <Space> <Nop>

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Mostrar undotree
nnoremap <leader>u :UndotreeToggle<CR>:wincmd h<CR>

" Copiar al clipboard del sistema
nnoremap <leader>y "*yy
vnoremap <leader>y "*y

" FZF
" Buscar ficheros en el directorio actual con Ctrl+F
" El '!' hace de toggle
map <C-f> <Esc><Esc>:Files!<CR>

" lo mismo, pero busca tambien ficheros ocultos
function! MyFZF()
    let $FZF_DEFAULT_COMMAND='find . -not -path "*/\.git*" -type f -print'
    Files!
    unlet $FZF_DEFAULT_COMMAND
endfunction
map <C-p> <Esc><Esc>:call MyFZF()<CR>

" Si estamos en INSERT, busca dentro del documento
inoremap <C-f> <Esc><Esc>:BLines!<CR>

" Current file Commits con Ctrl+G
map <C-g> <Esc><Esc>:BCommits!<CR>
" All commits with <leader>G
map <leader>G <Esc><Esc>:Commits!<CR>

" Permite moverte con TAB (en normal mode) de un [ ..... a otro ]
nnoremap <TAB> %

" Muestra los buffers actuales
nnoremap <leader>b :Buffers<CR>

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

" Palabra a mayusculas
nnoremap <c-u> gUiw
" A minusculas
nnoremap <c-l> guiw

" muestra el commit de la linea actual, o las lineas seleccionadas con visual
if has('nvim')
    let g:git_messenger_no_default_mappings = v:true
    map <Leader>g <Plug>(git-messenger)
else
    map <silent><Leader>g :call setbufvar(winbufnr(popup_atcursor(systemlist("cd " . shellescape(fnamemodify(resolve(expand('%:p')), ":h")) . " && git log --no-merges -n 1 -L " . shellescape(line("v") . "," . line(".") . ":" . resolve(expand("%:p")))), { "padding": [1,1,1,1], "pos": "botleft", "wrap": 0 })), "&filetype", "git")<CR>
endif

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
