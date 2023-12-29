return {
  "rebelot/kanagawa.nvim",
  dependencies = {
    "ellisonleao/gruvbox.nvim",
  },
  lazy = false,
  priority = 1000,

  config = function() require("aorith.plugins.colorscheme.config").setup() end,
}