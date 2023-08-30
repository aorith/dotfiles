return {
  {
    "bluz71/vim-nightfly-colors",
    enabled = false,
    name = "nightfly",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme nightfly")
    end,
  },

  {
    "folke/tokyonight.nvim",
    enabled = true,
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd("colorscheme tokyonight-moon")
    end,
  },
}
