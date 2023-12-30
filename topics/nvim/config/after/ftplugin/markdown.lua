vim.opt_local.colorcolumn = "0"
vim.opt_local.conceallevel = 2

-- Inserts a new empty code block below the current line
local function insertCodeBlock()
  local win = vim.api.nvim_get_current_win()
  local row, col = unpack(vim.api.nvim_win_get_cursor(win))

  -- Insert the text in a new line below the current line
  vim.api.nvim_buf_set_lines(0, row, row, false, { "```", "```" })

  local newRow = row + 1 -- Move cursor down one line
  local newCol = 4

  vim.api.nvim_win_set_cursor(win, { newRow, newCol })
end

map("n", "<LocalLeader>c", insertCodeBlock, { buffer = 0, desc = "Insert code block" })
