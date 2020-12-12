" See :h nvim-defaults

"set Vim-specific sequences for RGB colors
if &term !~? 'screen\|tmux'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

let &t_ut='' " disable background color erase

set scrolloff=3
set showtabline=2
set showmatch
set number
set hidden
set noerrorbells
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
set smartindent
set copyindent
set cindent cinkeys-=0# " dont mess with comment indentation
set foldmethod=syntax
set foldlevel=99
set foldlevelstart=99
set ffs=unix,dos,mac

set completeopt+=menuone,noselect
"inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

set shortmess+=c   " Shut off completion messages

if exists('+signcolumn')
    set signcolumn=yes
endif

setglobal textwidth=0

set mouse=a

set ignorecase smartcase gdefault

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Decent wildmenu
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" I can open the help with :help, kthx
map <F1> <nop>
map! <F1> <nop>

" directories
if !isdirectory($HOME . "/.local/share/nvim/backup")
	call mkdir($HOME . "/.local/share/nvim/backup", "p", 0700)
endif
if !isdirectory($HOME . "/.local/share/nvim/undodir")
	call mkdir($HOME . "/.local/share/nvim/undodir", "p", 0700)
endif

set undodir=~/.local/share/nvim/undodir//
set undolevels=1000 undoreload=10000
set backupdir=~/.local/share/nvim/backup//
set directory=~/.local/share/nvim/swap//

set swapfile
set nobackup
set undofile

function! ToggleBackground()
    if &background ==# 'light'
        set background=dark
    else
        set background=light
    endif
endfunction

function! SetTermguicolors()
    if has('termguicolors')
        set termguicolors
    endif
endfunction

