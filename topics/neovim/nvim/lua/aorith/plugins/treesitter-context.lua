return {
  "nvim-treesitter/nvim-treesitter-context",
  -- enable with <leader>tx
  config = function() require("treesitter-context").setup({ enable = false }) end,
}
