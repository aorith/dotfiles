return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- setup basic lsp config
      require("plugins.config.lsp.handlers").setup()
    end,
  },
}
