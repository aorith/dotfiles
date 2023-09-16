local theme = "kanagawa"

return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
    config = function()
      if theme == "tokyonight" then
        vim.cmd("colorscheme tokyonight-moon")
      end
    end,
  },

  {
    "rebelot/kanagawa.nvim",
    cmd = { "KanagawaCompile" },
    build = ":KanagawaCompile",
    lazy = false,
    priority = 1000,
    config = function()
      if theme == "kanagawa" then
        require("kanagawa").setup({
          compile = true, -- enable compiling the colorscheme
        })

        vim.cmd("colorscheme kanagawa")
      end
    end,
  },

  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      if theme == "onedark" then
        vim.cmd.colorscheme("onedark")
      end
    end,
  },

  {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    config = function()
      if theme == "catppuccin" then
        vim.cmd.colorscheme("catppuccin")
      end
    end,
    priority = 1000,
  },

  {
    "sainnhe/gruvbox-material",
    lazy = false,
    config = function()
      if theme == "gruvbox" then
        vim.cmd.colorscheme("gruvbox-material")
      end
    end,
    priority = 1000,
  },

  {
    "yorickpeterse/nvim-grey",
    lazy = false,
    config = function()
      if theme == "grey" then
        vim.cmd.colorscheme("grey")
      end
    end,
    priority = 1000,
  },

  {
    "ramojus/mellifluous.nvim",
    lazy = false,
    config = function()
      if theme == "mellifluous" then
        vim.cmd.colorscheme("mellifluous")
      end
    end,
    priority = 1000,
  },

  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    config = function()
      if theme == "rosepine" then
        require("rose-pine").setup({
          --disable_background = true,
          --disable_float_background = true,
        })
        vim.cmd.colorscheme("rose-pine")
      end
    end,
    priority = 1000,
  },

  {
    "savq/melange-nvim",
    lazy = false,
    config = function()
      if theme == "melange" then
        vim.cmd.colorscheme("melange")
      end
    end,
    priority = 1000,
  },

  {
    "projekt0n/caret.nvim",
    lazy = false,
    config = function()
      if theme == "caret" then
        vim.cmd.colorscheme("caret")
      end
    end,
    priority = 1000,
  },
}
