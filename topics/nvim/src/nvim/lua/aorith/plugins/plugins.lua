require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use 'mhinz/vim-signify'
    use 'fgsch/vim-varnish'
    use 'sheerun/vim-polyglot'
    use 'ojroques/nvim-osc52'
    use 'psf/black'

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
    use 'hrsh7th/cmp-vsnip'
    use 'hrsh7th/vim-vsnip'

    use {
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup {}
        end
    }

    use {
        'nvim-tree/nvim-tree.lua',
        requires = {
            'nvim-tree/nvim-web-devicons', -- optional, for file icons
        },
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
    use { 'folke/tokyonight.nvim', opt = false }
    use { 'joshdick/onedark.vim', opt = true }
    use { 'rebelot/kanagawa.nvim', opt = false }
    use { 'sainnhe/gruvbox-material', opt = false }
    use { "ellisonleao/gruvbox.nvim", opt = false }

end)

-- Theme
require("gruvbox").setup({
    undercurl = true,
    underline = true,
    bold = true,
    italic = true,
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = "", -- can be "hard", "soft" or empty string
    palette_overrides = {},
    overrides = {},
    dim_inactive = false,
    transparent_mode = false,
})


require("tokyonight").setup({
  -- your configuration comes here
  -- or leave it empty to use the default settings
  style = "storm", -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
  light_style = "day", -- The theme is used when the background is set to light
  transparent = false, -- Enable this to disable setting the background color
  terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
  styles = {
    -- Style to be applied to different syntax groups
    -- Value is any valid attr-list value for `:help nvim_set_hl`
    comments = { italic = true },
    keywords = { italic = true },
    functions = {},
    variables = {},
    -- Background styles. Can be "dark", "transparent" or "normal"
    sidebars = "dark", -- style for sidebars, see below
    floats = "dark", -- style for floating windows
  },
  sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
  day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
  hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
  dim_inactive = false, -- dims inactive windows
  lualine_bold = false, -- When `true`, section headers in the lualine theme will be bold

  --- You can override specific color groups to use other groups or a hex color
  --- function will be called with a ColorScheme table
  ---@param colors ColorScheme
  on_colors = function(colors) end,

  --- You can override specific highlights to use other groups or a hex color
  --- function will be called with a Highlights and ColorScheme table
  ---@param highlights Highlights
  ---@param colors ColorScheme
  on_highlights = function(highlights, colors) end,
})

vim.o.background = "dark"
vim.cmd("colorscheme tokyonight")


-- Configuration
require("nvim-tree").setup()

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
