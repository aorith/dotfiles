" vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')
source ~/.config/nvim/configs/plugins/themes.vim
source ~/.config/nvim/configs/plugins/undotree.vim
source ~/.config/nvim/configs/plugins/git.vim
source ~/.config/nvim/configs/plugins/fzf.vim
source ~/.config/nvim/configs/plugins/polyglot.vim
source ~/.config/nvim/configs/plugins/mucomplete.vim

Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'kyazdani42/nvim-tree.lua'

" Nvim Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}


" Trouble
Plug 'folke/trouble.nvim'

if hostname() !~? 'admin.*'
    source ~/.config/nvim/configs/plugins/black.vim
endif

call plug#end()

" Nvim Treesitter
source ~/.config/nvim/configs/plugins/treesitter.vim

" Trouble
lua << EOF
  require("trouble").setup {
  }
EOF
