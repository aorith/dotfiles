" Leader
let mapleader = " "
" this avoids a sending a space when timeoutlen expires in normal mode
nnoremap <Space> <Nop>
let localmapleader = ","

set rulerformat=%60(%=%#ModeMsg#%(%m%)%#Mode#\ %y\ (%l:%c\ 0x%B\ %p%%)\ B:%n%)
set shell=/usr/bin/env\ bash
set autoread " read file again if modified on disk and no unsaved changes
set backupcopy=yes " https://github.com/srid/emanote/issues/180
set virtualedit=block
set showcmd cmdheight=2 showmode
set scrolloff=4 sidescrolloff=5
set number
set hidden
set hlsearch incsearch ignorecase smartcase infercase
set noerrorbells
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab
set cindent noautoindent nosmartindent
set cinkeys-=0# " dont indent '#'
set indentkeys-=0#
set wrap wrapscan linebreak breakindent showbreak=↳\ 
set textwidth=80
set swapfile backup undofile
set title icon
let &titlestring = "vim(%t)"
set foldenable foldlevel=999 foldmethod=indent
set updatetime=400 " swap & CursorHold
set fileformats=unix,dos,mac
set nostartofline nofixendofline
set history=100
set report=0 " always report number of lines changed after :command
set splitright splitbelow
set formatoptions=jnlq
set shortmess+=Ic
set mouse=a
set colorcolumn=80
set cursorline
if exists('+cursorlineopt')
  set cursorlineopt=number
endif
set listchars=eol:¬,tab:▸\ ,nbsp:‗,trail:·,extends:→,precedes:←
set fillchars=vert:┃,fold:·
set spellcapcheck= " dont check for Capitals

set ttyfast lazyredraw
set signcolumn=yes
" timeoutlen works on <leader> mappings
set timeout timeoutlen=1000 ttimeoutlen=100

" clipboard to system
"set clipboard=unnamed,unnamedplus

" Completion
set complete=.,w,b,k,kspell
set completeopt=menuone,noselect,noinsert

" Decent wildmenu
set path+=**
set wildmenu
set wildmode=longest:full,full
set wildignore=*.pyc,*.hg,*.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db
set wildignore+=*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

set viminfo+=n~/.local/share/vim/viminfo
set undodir=~/.local/share/vim/undodir//
set undolevels=1000 undoreload=10000
set backupdir=~/.local/share/vim/backup//
set directory=~/.local/share/vim/swap//

" Highligh extra whitespace
match ErrorMsg '\s\+$'
