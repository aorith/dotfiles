set fileencodings=ucs-bom,utf-8,default,latin1
set encoding=utf-8
scriptencoding utf-8

syntax enable
filetype plugin indent on

set virtualedit=block
set backspace=eol,indent,start
set showcmd cmdheight=2
set showtabline=2
set scrolloff=4
if !&sidescrolloff
  set sidescrolloff=5
endif
set showmatch
set number
"set numberwidth=1 " Dynamically resize the 'number' column
set hidden
set hlsearch incsearch ignorecase smartcase
set noerrorbells
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
set autoindent smartindent
set wrap linebreak breakindent
set noswapfile backup undofile
set laststatus=2
set title
let &titlestring= hostname() . "(%t)"
set foldmethod=syntax
set foldlevelstart=999 " no fold by default
"set foldcolumn=2
set foldenable
set updatetime=100
set fileformats=unix,dos,mac
set nostartofline " dont go to start of line in many cases
set autoread " read file again if modified on disk and no unsaved changes
set history=100
set report=0 " always report number of lines changed after :command
set splitright splitbelow
set formatoptions=cqjl
set completeopt=menuone,noinsert,noselect,popup
set shortmess+=Ic
set mouse=a ttymouse=xterm2
set colorcolumn=80

" performance
"syntax sync minlines=2000
"syntax sync maxlines=5000
"set synmaxcol=400

" list chars
if has('multi_byte')
    set listchars=eol:¬,tab:▸\ ,trail:·,extends:→,precedes:←
    if v:version >= 700
        set listchars+=nbsp:‗
    endif
else
    set listchars=eol:$,tab:>-,trail:.,extends:>,precedes:<
endif

set lazyredraw display=lastline
set ttyfast
if exists('+signcolumn')
    set signcolumn=yes
endif
set ttimeout
set ttimeoutlen=100 " Quickly detect normal escape sequences

" clipboard to system
"set clipboard=unnamed,unnamedplus

" Decent wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

set viminfo+=n~/.local/share/vim/viminfo
set undodir=~/.local/share/vim/undodir//
set undolevels=1000 undoreload=10000
set backupdir=~/.local/share/vim/backup//
set directory=~/.local/share/vim/swap//

" I can open it with :help - it's remaped later in themes/dynamic.vim
map <F1> <nop>
map! <F1> <nop>
