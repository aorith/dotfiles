return {
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
    opts = { input = { relative = "win" }, select = { enabled = false } },
  },

  {
    "lukas-reineke/headlines.nvim",
    lazy = false,
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("headlines").setup({
        markdown = {
          headline_highlights = false,
          fat_headlines = false,
        },
        norg = {
          headline_highlights = false,
        },
      })
    end,
  },
}
