return {
  {
    "stevearc/dressing.nvim",
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

  {
    "MunifTanjim/nui.nvim",
  },

  {
    "nvim-lua/plenary.nvim",
  },
}
