return {
  {
    enabled = false,
    "folke/tokyonight.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      vim.cmd.colorscheme("tokyonight")
    end,
  },
  {
    enabled = true,
    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        flavour = "mocha", -- latte, frappe, macchiato, mocha
        background = { -- :h background
          light = "latte",
          dark = "macchiato",
        },
        transparent_background = false,
        show_end_of_buffer = true, -- show the '~' characters after the end of buffers
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },
  {
    enabled = false,
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("kanagawa")
    end,
  },
  {
    enabled = false,
    "mcchrish/zenbones.nvim",
    dependencies = {
      { "rktjmp/lush.nvim", lazy = false },
    },
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[
      "let g:zenbones_compat = 1
      ]])
      vim.cmd.colorscheme("zenbones")
    end,
  },
}
