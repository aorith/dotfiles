return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-vsnip',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-nvim-lua',
      'hrsh7th/cmp-path',
    }
  }

  use 'neovim/nvim-lspconfig';
  use 'nvim-treesitter/nvim-treesitter';

  use 'junegunn/fzf';
  use 'junegunn/fzf.vim';

  use 'ojroques/nvim-lspfuzzy'; -- Let LSP use fzf

  use 'rhysd/git-messenger.vim';

  use 'lukas-reineke/indent-blankline.nvim';

  use 'sheerun/vim-polyglot'; -- syntax for multiple langs

  -- Themes
  use 'hoob3rt/lualine.nvim'; -- Status line
  use 'kyazdani42/nvim-web-devicons'; -- For Lualine
  use 'projekt0n/github-nvim-theme';
  use 'gruvbox-community/gruvbox'; -- no lua
  use 'protesilaos/tempus-themes-vim'; -- no lua
  use 'romainl/Apprentice'; -- no lua
  use 'lifepillar/vim-solarized8'; -- no lua
  -- use 'arcticicestudio/nord-vim'; -- no support for TreeSitter
  use 'shaunsingh/nord.nvim';
  use 'jnurmine/Zenburn'; -- no lua

  use 'a-vrma/black-nvim'; -- Black
  use 'dstein64/vim-startuptime' -- Show startup details with ':StartupTime'
  use 'mhinz/vim-signify' -- Version control on the sign column
end)
