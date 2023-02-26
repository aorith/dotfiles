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
  map("n", "<leader>lh", vim.lsp.buf.hover, "[H]over")
  map("n", "<leader>ll", vim.diagnostic.open_float, "[L]ine diagnostics")
  map("n", "<leader>lq", vim.diagnostic.setloclist, "Set Loc List")
  map("n", "<leader>lj", vim.diagnostic.goto_next, "Next diagnostic")
  map("n", "<leader>lk", vim.diagnostic.goto_prev, "Prev diagnostic")
  map("n", "<leader>lr", vim.lsp.buf.rename, "[R]ename")
  map("n", "<leader>ls", vim.lsp.buf.signature_help, "[S]ignature")

  -- Go to
  map("n", "<leader>lgc", vim.lsp.buf.declaration, "De[c]laration")
  map("n", "<leader>lgd", vim.lsp.buf.definition, "[D]efinition")
  map("n", "<leader>lgi", vim.lsp.buf.implementation, "[I]mplementation")
  map("n", "<leader>lgr", vim.lsp.buf.references, "[R]eferences")
  map("n", "<leader>lgt", vim.lsp.buf.type_definition, "[T]ype definitions")
  -- without leader
  map("n", "gd", vim.lsp.buf.definition, "[G]oto [D]efinition")
  map("n", "gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
  map("n", "gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
  map("n", "gI", vim.lsp.buf.implementation, "[G]oto [I]mplementation")
  map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
end

return M
