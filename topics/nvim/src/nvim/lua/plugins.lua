return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'

  use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/vim-vsnip',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
    }
  }

  use 'neovim/nvim-lspconfig';
  use 'nvim-treesitter/nvim-treesitter';

  use 'junegunn/fzf';
  use 'junegunn/fzf.vim';

  use 'ojroques/nvim-lspfuzzy'; -- Let LSP use fzf

  use 'rhysd/git-messenger.vim';

  -- Themes
  use 'hoob3rt/lualine.nvim'; -- Status line
  use 'kyazdani42/nvim-web-devicons'; -- For Lualine
  use 'projekt0n/github-nvim-theme';
end)