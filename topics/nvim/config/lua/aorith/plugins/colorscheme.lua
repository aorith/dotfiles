local theme = "tokyonight"

return {
  {
    "bluz71/vim-nightfly-colors",
    enabled = theme == "nightfly",
    name = "nightfly",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme nightfly")
    end,
  },

  {
    "folke/tokyonight.nvim",
    enabled = theme == "tokyonight",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      vim.cmd("colorscheme tokyonight-moon")
    end,
  },

  {
    "rebelot/kanagawa.nvim",
    enabled = theme == "kanagawa",
    cmd = { "KanagawaCompile" },
    build = ":KanagawaCompile",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        compile = true, -- enable compiling the colorscheme
      })

      vim.cmd("colorscheme kanagawa")
    end,
  },

  { -- Theme inspired by Atom
    "navarasu/onedark.nvim",
    enabled = theme == "onedark",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("onedark")
    end,
  },
}
