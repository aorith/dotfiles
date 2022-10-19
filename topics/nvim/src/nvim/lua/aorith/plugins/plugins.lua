require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'mhinz/vim-signify'
    use 'fgsch/vim-varnish'
    use 'sheerun/vim-polyglot'
    use 'ojroques/nvim-osc52'

    use({
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } }
    })
    use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

    use 'neovim/nvim-lspconfig'
    use 'nvim-treesitter/nvim-treesitter'

    use 'hrsh7th/nvim-cmp'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/cmp-nvim-lua'

    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {}
        end
    }

    use {
        'nvim-lualine/lualine.nvim',
        requires = { 'kyazdani42/nvim-web-devicons' }
    }

    -- autoinstall language servers
    use 'williamboman/mason.nvim'
    use 'williamboman/mason-lspconfig.nvim'

    -- themes
    use { 'jacoborus/tender.vim', opt = true }
    use { 'folke/tokyonight.nvim', opt = true }
    use { 'joshdick/onedark.vim', opt = true }
    use { 'rebelot/kanagawa.nvim', opt = true }
    use { 'sainnhe/gruvbox-material', opt = false }

end)

-- Configuration
require('telescope').load_extension('fzf')

require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto'
    }
}

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "sumneko_lua" }
})

require("aorith.plugins.config.lsp")
require("aorith.plugins.config.cmp")
require("aorith.plugins.config.treesitter")
require("aorith.plugins.config.whichkey")
