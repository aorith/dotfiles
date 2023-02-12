local _M = {}

function _M.setup()
  local km = vim.keymap
  km.set("n", "<leader><TAB>", "<cmd>bnext<CR>", { desc = "Next buffer" })

  -- osc52 copy
  km.set("n", "<leader>c", require("osc52").copy_operator, { expr = true, desc = "Osc52 copy operator" })
  km.set("x", "<leader>y", require("osc52").copy_visual, { desc = "Osc52 copy visual selection" })
  km.set("n", "<leader>y", "<leader>c_", { remap = true, desc = "Osc52 copy current line" })

  km.set("n", "<leader>/", "<cmd>nohl<CR>", { desc = "Disable current highligh (nohl)" })
  km.set("n", "x", '"_x', { desc = "Avoid 'x' copying to the register" })

  -- Explorer
  km.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "File Explorer" })

  -- Undotree
  km.set("n", "<leader>u", "<cmd>UndotreeToggle<CR>", { desc = "Undotree" })

  -- Telescope
  km.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
  km.set("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", { desc = "Find diagnostics" })
  km.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
  km.set("n", "<leader>fF", "<cmd>Telescope git_files<CR>", { desc = "Find git files" })
  km.set("n", "<leader>fG", "<cmd>Telescope live_grep<CR>", { desc = "Grep all" })
  km.set("n", "<leader>fg", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Grep buffer" })
  km.set("n", "<leader>fo", "<cmd>Telescope jumplist<CR>", { desc = "Jumplist" })

  -- Git
  km.set("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle blame" })
  km.set("n", "<leader>gw", "<cmd>Gitsigns toggle_word_diff<CR>", { desc = "Toggle word diff" })
  km.set("n", "<leader>gd", "<cmd>DiffviewFileHistory %<CR>", { desc = "Diffview current's file history" })
  km.set("n", "<leader>gD", "<cmd>DiffviewFileHistory<CR>", { desc = "Diffview all files history" })

  -- Get highlight group under cursor
  km.set("n", "<C-e>", function()
    local result = vim.treesitter.get_captures_at_cursor(0)
    print(vim.inspect(result))
  end, { desc = "highlight group under cursor" })
end

function _M.lsp_keymaps(bufnr)
  local keymap = function(mode, map, cmd, desc)
    local bufopts = { noremap = true, silent = true, buffer = bufnr, desc = desc }
    vim.keymap.set(mode, map, cmd, bufopts)
  end

  keymap("n", "<leader>lc", vim.lsp.buf.code_action, "Code actions")
  keymap("n", "<leader>lf", function()
    vim.lsp.buf.format({ timeout_ms = 3000 })
  end, "Format")
  keymap("n", "<leader>lh", vim.lsp.buf.hover, "Hover")
  keymap("n", "<leader>ll", vim.diagnostic.open_float, "Line diagnostics")
  keymap("n", "<leader>lq", vim.diagnostic.setloclist, "Set Loc List")
  keymap("n", "<leader>lj", vim.diagnostic.goto_next, "Next diagnostic")
  keymap("n", "<leader>lk", vim.diagnostic.goto_prev, "Prev diagnostic")
  keymap("n", "<leader>lr", vim.lsp.buf.rename, "Rename")
  keymap("n", "<leader>ls", vim.lsp.buf.signature_help, "Signature")

  -- Workspace
  keymap("n", "<space>wa", vim.lsp.buf.add_workspace_folder, "Add workspace")
  keymap("n", "<space>wr", vim.lsp.buf.remove_workspace_folder, "Remove workspace")
  keymap("n", "<space>wl", function()
    dumpp(vim.lsp.buf.list_workspace_folders())
  end, "List workspaces")

  -- Go to
  keymap("n", "<leader>lgc", vim.lsp.buf.declaration, "Declaration")
  keymap("n", "<leader>lgd", vim.lsp.buf.definition, "Definition")
  keymap("n", "<leader>lgi", vim.lsp.buf.implementation, "Implementation")
  keymap("n", "<leader>lgr", vim.lsp.buf.references, "References")
  keymap("n", "<leader>lgt", vim.lsp.buf.type_definition, "Type definitions")
end

return _M
