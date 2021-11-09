" --- OPTIONS BEFORE ----------------------------------------------------------
source ~/.vim/configs/plugin_options.vim
" --- END----------------------------------------------------------------------

" Download vim-plug when missing
if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" --- START -------------------------------------------------------------------
call plug#begin('~/.vim/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'mhinz/vim-signify'
Plug 'dense-analysis/ale'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

if empty($SSH_CLIENT)
    Plug 'aorith/znotes.vim'
end

Plug 'romainl/Apprentice'
"Plug 'protesilaos/tempus-themes-vim'
Plug 'lifepillar/vim-solarized8'
Plug 'gruvbox-community/gruvbox'
Plug 'dracula/vim', { 'as': 'dracula' }
call plug#end()
" --- END ---------------------------------------------------------------------

" --- OPTIONS AFTER -----------------------------------------------------------
set omnifunc=ale#completion#OmniFunc
" --- END ---------------------------------------------------------------------
