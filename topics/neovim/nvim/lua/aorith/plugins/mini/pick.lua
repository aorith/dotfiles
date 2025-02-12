local M = {}

M.setup = function()
  ---@diagnostic disable-next-line: redundant-parameter
  require("mini.pick").setup({
    mappings = {
      choose = "<CR>",
      choose_in_split = "<C-s>",
      choose_in_tabpage = "<C-t>",
      choose_in_vsplit = "<C-v>",

      choose_marked = "<C-q>",
      mark = "<C-x>",
      mark_all = "<C-a>",
    },
  })
  vim.ui.select = MiniPick.ui_select

  map("n", "<leader><leader>", [[<Cmd>Pick buffers include_current=false<CR>]], { desc = "Buffers" })
  map("n", "<leader>ff", [[<Cmd>Pick files<CR>]], { desc = "Files" })
  map("n", "<leader>fg", [[<Cmd>Pick grep_live<CR>]], { desc = "Grep live" })
  map("n", "<leader>fG", [[<Cmd>Pick git_files<CR>]], { desc = "Find git files" })
  map("n", "<leader>fb", [[<Cmd>Pick buf_lines scope='all'<CR>]], { desc = "Grep open buffers" })
  map("n", "<leader>fr", [[<Cmd>Pick resume<CR>]], { desc = "Resume" })
  map("n", "<leader>fd", [[<Cmd>Pick diagnostic scope='all'<CR>]], { desc = "Diagnostic workspace" })
  map("n", "<leader>fD", [[<Cmd>Pick diagnostic scope='current'<CR>]], { desc = "Diagnostic buffer" })

  map("n", "<leader>gl", [[<Cmd>Pick git_commits<CR>]], { desc = "Logs/Commits (all)" })
  map("n", "<leader>gL", [[<Cmd>Pick git_commits path='%'<CR>]], { desc = "Logs/Commits (current)" })
  map("n", "<leader>ga", [[<Cmd>Pick git_hunks scope='staged'<CR>]], { desc = "Added hunks (all)" })
  map("n", "<leader>gA", [[<Cmd>Pick git_hunks path='%' scope='staged'<CR>]], { desc = "Added hunks (current)" })
  map("n", "<leader>gm", [[<Cmd>Pick git_hunks<CR>]], { desc = "Modified hunks (all)" })
  map("n", "<leader>gM", [[<Cmd>Pick git_hunks path='%'<CR>]], { desc = "Modified hunks (current)" })
  map("n", "<leader>gB", [[<Cmd>Pick git_branches<CR>]], { desc = "Branches" })
  map("n", "<leader>gb", [[<Cmd>Gitsigns blame<CR>]], { desc = "Blame" })

  map("n", "<leader>fh", [[<Cmd>Pick help<CR>]], { desc = "Help tags" })
  map("n", "<leader>fH", [[<Cmd>Pick hl_groups<CR>]], { desc = "Highlight groups" })
  map("n", "<leader>fp", [[<Cmd>Pick spellsuggest<CR>]], { desc = "Spell suggest" })
  map("n", "<leader>fk", [[<Cmd>Pick keymaps<CR>]], { desc = "Keymaps" })

  -- Toggles
  map("n", "<leader>tb", require("gitsigns").toggle_current_line_blame, { desc = "Toggle current line blame" })
  map("n", "<leader>td", require("gitsigns").toggle_deleted, { desc = "Toggle git deleted" })
  map("n", "<leader>tw", require("gitsigns").toggle_word_diff, { desc = "Toggle git word diff" })

  -- LSP
  map("n", "gd", "<Cmd>Pick lsp scope='definition'<CR>", { desc = "Definitions" })
  map("n", "gD", "<Cmd>Pick lsp scope='declaration'<CR>", { desc = "Declaration" })
  map("n", "gr", "<Cmd>Pick lsp scope='references'<CR>", { desc = "References" })
  map("n", "gI", "<Cmd>Pick lsp scope='implementation'<CR>", { desc = "Implementation" })
  map("n", "gy", "<Cmd>Pick lsp scope='type_definition'<CR>", { desc = "Type Definitions" })
  map("n", "<leader>ss", [[<Cmd>Pick lsp scope='document_symbol'<CR>]], { desc = "Symbols buffer (LSP)" })
  map("n", "<leader>sS", [[<Cmd>Pick lsp scope='workspace_symbol'<CR>]], { desc = "Symbols workspace (LSP)" })
end

return M
