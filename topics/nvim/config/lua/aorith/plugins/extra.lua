return {
  {
    "MunifTanjim/nui.nvim",
    lazy = false,
  },

  {
    "nvim-lua/plenary.nvim",
    lazy = false,
  },

  {
    "tpope/vim-fugitive",
    lazy = true,
    cmd = { "Git", "G" },
  },

  {
    "stevearc/dressing.nvim",
    lazy = false,
    config = function()
      require("dressing").setup({
        input = {
          win_options = {
            -- Window transparency (0-100)
            winblend = 0,
          },
        },
      })
    end,
  },

  -- {
  --   "rcarriga/nvim-notify",
  --   lazy = false,
  --   config = function()
  --     ---@diagnostic disable: missing-fields
  --     require("notify").setup({
  --       stages = "static",
  --       render = "wrapped-compact",
  --       minimum_width = 30,
  --     })
  --
  --     vim.notify = require("notify")
  --   end,
  -- },

  {
    "lukas-reineke/headlines.nvim",
    lazy = true,
    event = "VeryLazy",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {
      markdown = {
        -- headline_highlights = false,
        fat_headlines = false,
      },
      norg = {
        headline_highlights = false,
      },
    },
  },
}
