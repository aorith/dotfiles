local M = {}

function M.set_keymaps(bufnr)
  local map = function(mode, map, cmd, desc)
    local bufopts = { noremap = true, silent = true, buffer = bufnr, desc = desc }
    vim.keymap.set(mode, map, cmd, bufopts)
  end

  map("n", "<leader>lc", vim.lsp.buf.code_action, "Code actions")
  map("n", "<leader>lf", function()
    vim.lsp.buf.format({ timeout_ms = 3000 })
  end, "Format")
  map("n", "<leader>lh", vim.lsp.buf.hover, "Hover")
  map("n", "<leader>ll", vim.diagnostic.open_float, "Line diagnostics")
  map("n", "<leader>lq", vim.diagnostic.setloclist, "Set Loc List")
  map("n", "<leader>lj", vim.diagnostic.goto_next, "Next diagnostic")
  map("n", "<leader>lk", vim.diagnostic.goto_prev, "Prev diagnostic")
  map("n", "<leader>lr", vim.lsp.buf.rename, "Rename")
  map("n", "<leader>ls", vim.lsp.buf.signature_help, "Signature")

  -- Go to
  map("n", "<leader>lgc", vim.lsp.buf.declaration, "Declaration")
  map("n", "<leader>lgd", vim.lsp.buf.definition, "Definition")
  map("n", "<leader>lgi", vim.lsp.buf.implementation, "Implementation")
  map("n", "<leader>lgr", vim.lsp.buf.references, "References")
  map("n", "<leader>lgt", vim.lsp.buf.type_definition, "Type definitions")
end

return M
