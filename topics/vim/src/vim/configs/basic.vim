set fileencodings=ucs-bom,utf-8,default,latin1
set encoding=utf-8
scriptencoding utf-8

" change cursor
if has('nvim') && !has('nvim-0.2')
    let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1
elseif &term =~? 'xterm\|screen\|tmux\|alacritty'
    let &t_SI.="\e[5 q" "SI = INSERT mode
    let &t_SR.="\e[4 q" "SR = REPLACE mode
    let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
endif

"set Vim-specific sequences for RGB colors
if &term !~? 'screen\|tmux'
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

let &t_ut='' " disable background color erase

if has('autocmd')
  filetype plugin indent on
endif
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

set backspace=eol,indent,start
set showcmd
set display+=lastline
set showtabline=2
set scrolloff=4
if !&sidescrolloff
  set sidescrolloff=5
endif
set showmatch
set number
"set numberwidth=1 " Dynamically resize the 'number' column
set hidden
set hlsearch
set noerrorbells
set tabstop=4 softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set smartindent
set cindent cinkeys-=0# " dont mess with comment indentation
set swapfile
set backup
set undofile
set laststatus=2
set title
let &titlestring= hostname() . "(%t)"
set titleold=
set foldmethod=syntax
set foldlevelstart=999 " no fold by default
"set foldcolumn=2
set foldenable
set updatetime=100
set fileformats=unix,dos,mac
set nostartofline " dont go to start of line in many cases
set autoread " read file again if modified on disk and no unsaved changes
set history=1000
set report=0 " always report number of lines changed after :command
set splitright
set splitbelow
set shortmess-=m " dont display [+] instead of [modified]
set shortmess-=i
set shortmess-=l
set shortmess-=r
set shortmess-=a
set shortmess+=c   " Shut off completion messages

set completeopt+=menuone   " Show the popup if only one completion
set completeopt+=noinsert  " Don't insert text for a match unless selected
set completeopt+=noselect  " Don't auto-select the first match
set completeopt+=popup

" performance
"syntax sync minlines=2000
"syntax sync maxlines=5000
"set synmaxcol=400
set redrawtime=4000

" list chars
set nolist
if has('multi_byte')
    set listchars=eol:¬,tab:▸\ ,trail:·,extends:→,precedes:←
    if v:version >= 700
        set listchars+=nbsp:‗
    endif
else
    set listchars=eol:$,tab:>-,trail:.,extends:>,precedes:<
endif

set lazyredraw " do not redraw while running macros (much faster)
set ttyfast
if exists('+signcolumn')
    set signcolumn=yes
endif
set ttimeout
set ttimeoutlen=100 " Quickly detect normal escape sequences

" wrapping
setglobal textwidth=0 " set to 0 to avoid auto broke of lines
set wrap
set linebreak
set breakindent
"set showbreak=…

set formatoptions-=t " disable autowrap text with textwidth
set formatoptions-=c " disable autowrap comments with textwidth
set formatoptions-=q " disable formatting comments with gq

" clipboard to system
"set clipboard=unnamed,unnamedplus

" allows to click on coc-vim doc for example
set mouse=a

" more space for messages
set cmdheight=2

" 80 chars width
"set colorcolumn=80

" Proper search
set incsearch
set ignorecase
set smartcase
set gdefault

" Search results centered please
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz

" Decent wildmenu
set wildmenu
set wildmode=list:longest
set wildignore=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor

" I can open the help with :help, kthx
map <F1> <nop>
map! <F1> <nop>

" directories
if !isdirectory($HOME . '/.local/share/vim/swap')
	call mkdir($HOME . '/.local/share/vim/swap', 'p', 0700)
endif
if !isdirectory($HOME . '/.local/share/vim/undodir')
	call mkdir($HOME . '/.local/share/vim/undodir', 'p', 0700)
endif
if !isdirectory($HOME . '/.local/share/vim/backup')
	call mkdir($HOME . '/.local/share/vim/backup', 'p', 0700)
endif

set viminfo+=n~/.local/share/vim/viminfo
set undodir=~/.local/share/vim/undodir//
set undolevels=1000 undoreload=10000
set backupdir=~/.local/share/vim/backup//
set directory=~/.local/share/vim/swap//

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

function! SetVimFGBG(fg, bg)
    if &term !~? 'screen\|tmux'
        " this DOES NOT work on tmux since all panes and even the status bar
        " would apply the colors/reset, also for reference:
        " Escape sequences within tmux must be doubled
        " For ex: 'echo -en '\033Ptmux;\033\033]11;#003300\007\033\\''
        " will pass '\033]11;#003300\007' to the terminal
        let &t_ti = &t_ti . "\033]10;" . a:fg . "\007\033]11;" . a:bg ."\007"
        let &t_te = &t_te . "\033]110\007\033]111\007"

        " I need to enable syntax again on vim 8.2
        syntax enable
    endif
endfunction
