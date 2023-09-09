local M = {}

M.setup = function()
  require("mini.completion").setup({
    window = {
      info = { height = 25, width = 80, border = "rounded" },
      signature = { height = 25, width = 80, border = "rounded" },
    },

    lsp_completion = {
      source_func = "omnifunc",
      auto_setup = false,
      set_vim_settings = true,
    },
  })

  vim.keymap.set("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
  vim.keymap.set("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
end

return M
