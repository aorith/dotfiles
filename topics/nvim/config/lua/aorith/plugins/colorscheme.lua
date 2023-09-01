return {
  {
    'bluz71/vim-nightfly-colors',
    enabled = false,
    name = 'nightfly',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme nightfly')
    end,
  },

  {
    'folke/tokyonight.nvim',
    enabled = false,
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd('colorscheme tokyonight-moon')
    end,
  },

  {
    'rebelot/kanagawa.nvim',
    enabled = true,
    cmd = { 'KanagawaCompile' },
    build = ':KanagawaCompile',
    lazy = false,
    priority = 1000,
    config = function()
      require('kanagawa').setup({
        compile = true, -- enable compiling the colorscheme
      })

      vim.cmd('colorscheme kanagawa')
    end,
  },
}
