" vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" colors
Plug 'lokaltog/vim-monotone'
Plug 'romainl/Apprentice'
Plug 'lifepillar/vim-gruvbox8'
Plug 'lifepillar/vim-wwdc16-theme'
Plug 'arcticicestudio/nord-vim'
Plug 'altercation/vim-colors-solarized'
Plug 'srcery-colors/srcery-vim'
Plug 'protesilaos/tempus-themes-vim'

" undotree
Plug 'mbbill/undotree'

" fzf
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" vim fugitive (note: required by fzf)
Plug 'tpope/vim-fugitive'

" display git changes on sidebar
let g:signify_sign_change = '~'
let g:signify_priority = 9
if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

" tab completion
let g:mucomplete#enable_auto_at_startup = 1
Plug 'lifepillar/vim-mucomplete'

" Black for python (code formatter) format all the buffer with :Black
if hostname() !~? 'admin.*'
    Plug 'psf/black'
endif

" ALE
let g:ale_completion_enabled = 1 " disable for deoplete
let g:ale_completion_autoimport = 1
let g:ale_set_highlights = 1
let g:ale_exclude_highlights = ['line too long']
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 1
" window
let g:ale_list_window_size = 5
let g:ale_open_list = 0
let g:ale_keep_list_window_open = 0
Plug 'dense-analysis/ale'
set omnifunc=ale#completion#OmniFunc

if v:version >= 802
  " language pack
  Plug 'sheerun/vim-polyglot'
  " git diffs on current line
  Plug 'rhysd/git-messenger.vim'
endif

call plug#end()
