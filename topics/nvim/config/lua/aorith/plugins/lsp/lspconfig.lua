return {
  "neovim/nvim-lspconfig",

  dependencies = {
    "folke/neodev.nvim",
  },

  config = function()
    require("neodev").setup() -- make sure to setup neodev BEFORE lspconfig

    -- Log level
    vim.lsp.set_log_level("OFF")

    -- Diagnostics
    vim.diagnostic.config({
      signs = true,
      underline = true,
      update_in_insert = false, -- false so diags are updated on InsertLeave
      virtual_text = false,
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
      },
    })

    -- common handlers
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] =
      vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

    -- Setup servers
    require("aorith.plugins.lsp.servers.servers").setup()
  end,
}
