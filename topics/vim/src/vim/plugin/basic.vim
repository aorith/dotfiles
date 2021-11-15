filetype plugin indent on
if has("syntax")
  syntax enable
endif

" Sensible options
set backspace=indent,eol,start
set complete-=i
set nrformats-=octal
set laststatus=2
set ruler
set rulerformat=%60(%=%#ModeMsg#%(%m%)%#Mode#\ %y\ (%l:%c\ 0x%B\ %p%%)\ B:%n%)
set display+=lastline
set encoding=utf-8
set shell=/usr/bin/env\ bash
set autoread " read file again if modified on disk and no unsaved changes
set tabpagemax=50
if !exists('g:loaded_matchit')
  runtime! macros/matchit.vim
endif

" Leader
let mapleader = " "
let localmapleader = ","

set icon
set virtualedit=block
set showcmd cmdheight=2 showmode
set scrolloff=4 sidescrolloff=5
set number
set hidden
set hlsearch incsearch ignorecase smartcase
set noerrorbells
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab
set smartindent
set wrap wrapscan linebreak breakindent showbreak=↳\ 
set textwidth=100
set swapfile backup undofile
set title
let &titlestring = "vim(%t)"
set foldenable foldlevel=6 foldcolumn=1 foldmethod=indent
set updatetime=100
set fileformats=unix,dos,mac
set nostartofline nofixendofline
set history=100
set report=0 " always report number of lines changed after :command
set splitright splitbelow
set formatoptions=cqjlmM1
set shortmess+=Ic
set mouse=a ttymouse=xterm2
set colorcolumn=80
set cursorline
if exists('+cursorlineopt')
  set cursorlineopt=number
endif
set listchars=eol:¬,tab:▸\ ,nbsp:‗,trail:·,extends:→,precedes:←

" performance
"syntax sync minlines=2000
"syntax sync maxlines=5000
"set synmaxcol=400

set ttyfast
set signcolumn=yes
set ttimeout
set ttimeoutlen=400 " Quickly detect normal escape sequences

" clipboard to system
"set clipboard=unnamed,unnamedplus

" Decent wildmenu
set path+=**
set wildmenu
set wildmode=longest,list,full
set wildignore=*.pyc,*.hg,*.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db
set wildignore+=*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

set viminfo+=n~/.local/share/vim/viminfo
set undodir=~/.local/share/vim/undodir//
set undolevels=1000 undoreload=10000
set backupdir=~/.local/share/vim/backup//
set directory=~/.local/share/vim/swap//

" Highligh extra whitespace
match ErrorMsg '\s\+$'
