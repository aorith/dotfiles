" vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ---------------------- PLUG BEGIN ---------------------- "
call plug#begin('~/.config/nvim/plugged')
" -------------------------------------------------------- "
" Themes
Plug 'romainl/Apprentice'
Plug 'lifepillar/vim-gruvbox8'
Plug 'Shadorain/shadotheme'
Plug 'marko-cerovac/material.nvim'
Plug 'folke/tokyonight.nvim'
Plug 'savq/melange'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'kyazdani42/nvim-tree.lua'

" Undotree
Plug 'mbbill/undotree'

" Git
Plug 'tpope/vim-fugitive'
Plug 'mhinz/vim-signify'
Plug 'rhysd/git-messenger.vim'

" FZF
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/gv.vim'

" Polyglot
Plug 'sheerun/vim-polyglot'

" LSP
Plug 'neovim/nvim-lspconfig'
Plug 'folke/trouble.nvim'
" adds :LspInstall <language>
Plug 'kabouzeid/nvim-lspinstall'
" Signature (x, y, z ...) as you type
Plug 'ray-x/lsp_signature.nvim'

" Treesitter
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Completion
Plug 'hrsh7th/nvim-compe'

" Black for python (code formatter) format all the buffer with :Black
if hostname() !~? 'admin.*'
  Plug 'a-vrma/black-nvim', {'do': ':UpdateRemotePlugins'}
  command! -nargs=0 Black call Black()
endif
" -------------------------------------------------------- "
call plug#end()
" ---------------------- PLUG END ------------------------ "

" Extra configs
source ~/.config/nvim/configs/plugins/LSP.vim
source ~/.config/nvim/configs/plugins/treesitter.vim
