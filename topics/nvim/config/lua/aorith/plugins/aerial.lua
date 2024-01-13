map("n", "<leader>a", "<cmd>AerialToggle! right<cr>", { desc = "Aerial" })

return {
  "stevearc/aerial.nvim",
  lazy = true,
  cmd = "AerialToggle",
  opts = {},
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-tree/nvim-web-devicons",
  },
}
