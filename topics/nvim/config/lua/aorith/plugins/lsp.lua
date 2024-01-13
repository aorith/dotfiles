return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "folke/neodev.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
  },
  event = "BufEnter",

  config = function()
    -- Log level
    vim.lsp.set_log_level("OFF")

    -- Diagnostics
    vim.diagnostic.config({
      signs = { priority = 9999 },
      underline = true,
      update_in_insert = false, -- false so diags are updated on InsertLeave
      virtual_text = { severity = { min = "ERROR" } },
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

    require("aorith.plugins.lsp-config.servers").setup()
  end,
}
