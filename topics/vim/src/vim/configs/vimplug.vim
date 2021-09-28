" vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" display git changes on sidebar
let g:signify_sign_change = '~'
let g:signify_priority = 9
Plug 'mhinz/vim-signify'

" language syntax pack
Plug 'sheerun/vim-polyglot'

" colors
Plug 'romainl/Apprentice'
Plug 'protesilaos/tempus-themes-vim'

" tab completion
let g:mucomplete#enable_auto_at_startup = 1
Plug 'lifepillar/vim-mucomplete'

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

call plug#end()
