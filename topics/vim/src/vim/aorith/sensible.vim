set secure noexrc

set encoding=utf-8
scriptencoding utf-8

filetype plugin on
filetype indent on
if has("syntax")
  syntax enable
  set synmaxcol=400
endif

set backspace=indent,eol,start
set nrformats-=octal
set laststatus=2
set ruler
set display=lastline
set tabpagemax=50
if !exists('g:loaded_matchit')
  runtime! macros/matchit.vim
endif
