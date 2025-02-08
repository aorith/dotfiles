return {
  -- "folke/tokyonight.nvim",
  -- lazy = false,
  -- priority = 10000,
  --
  -- config = function()
  --   require("tokyonight").setup({
  --     style = "moon",
  --     dim_inactive = true, -- dims inactive windows
  --   })
  --
  --   vim.cmd.colorscheme("tokyonight")
  -- end,

  -- "rebelot/kanagawa.nvim",
  -- lazy = false,
  -- priority = 10000,
  --
  -- config = function()
  --   require("kanagawa").setup({
  --     theme = "wave", -- wave, dragon, lotus
  --     background = {
  --       dark = "wave", -- wave, dragon
  --       light = "lotus",
  --     },
  --     dimInactive = true,
  --   })
  --
  --   vim.cmd.colorscheme("kanagawa")
  -- end,

  "catppuccin/nvim",
  name = "catppuccin",
  priority = 10000,

  config = function()
    require("catppuccin").setup({
      background = {
        dark = "macchiato", -- frappe, macchiato, mocha
        light = "latte",
      },
      dim_inactive = { enabled = true },
      show_end_of_buffer = true,
    })

    vim.cmd.colorscheme("catppuccin")
  end,
}
