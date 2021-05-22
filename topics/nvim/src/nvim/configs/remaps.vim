" Remaps
let mapleader = "\<Space>"
nnoremap <Space> <Nop>

nnoremap <leader>h :wincmd h<CR>
nnoremap <leader>j :wincmd j<CR>
nnoremap <leader>k :wincmd k<CR>
nnoremap <leader>l :wincmd l<CR>

" Mostrar undotree
nnoremap <leader>u :UndotreeToggle<CR>:wincmd h<CR>

" Copy to system clipboard using osc52
nnoremap <leader>y V:OSCYank<CR>
vnoremap <leader>y :OSCYank<CR>

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
let g:git_messenger_no_default_mappings = v:true
map <Leader>g <Plug>(git-messenger)

" muestra los commits que afectan a la seleccion actual en visual mode
vmap <Leader>g :GV!<CR>

" Make :Q and :W work like :q and :w
command! W w
command! Q q

" netrw working like nerdtree
let g:netrw_banner = 1
let g:netrw_liststyle = 1
let g:netrw_browse_split = 3
let g:netrw_altv = 1
let g:netrw_winsize = 40
"nmap <silent> <leader>e :Lexplore<CR>

" NvimTree
nmap <silent> <leader>e :NvimTreeToggle<CR>
let g:nvim_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
let g:nvim_tree_auto_close = 1 "0 by default, closes the tree when it's the last window
let g:nvim_tree_quit_on_open = 1 "0 by default, closes the tree when you open a file
let g:nvim_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
let g:nvim_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:nvim_tree_add_trailing = 1 "0 by default, append a trailing slash to folder names
let g:nvim_tree_highlight_opened_files = 1 "0 by default, will enable folder and file icon highlight for opened files/directories.
let g:nvim_tree_lsp_diagnostics = 1 "0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
let g:nvim_tree_tab_open = 1 "0 by default, will open the tree when entering a new tab and the tree was previously open

" Run neorun.sh on current folder
function! NeoRun(arguments) abort
    botright new
    resize 15
    exec 'term ./neorun.sh ' . a:arguments
    startinsert
endfunction

command! -nargs=0 NeoRun call NeoRun(printf(expand('%')))
nnoremap <leader>nr :NeoRun<CR>

" Paste toggle
set pastetoggle=<F2>

" List toggle (:h map-modes)
map <silent> <F3> <Esc><Esc>:set list!<CR>
map! <silent> <F3> <Esc><Esc>:set list!<CR>
