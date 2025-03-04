vim.cmd("set spell")

vim.b.minihipatterns_config = {
  highlighters = {
    context = { pattern = "@%w+", group = "Directory" },
    prioA = { pattern = "^%(A%)", group = "ErrorMsg" },
    prioB = { pattern = "^%(B%)", group = "WarningMsg" },
    prioC = { pattern = "^%(C%)", group = "Constant" },
    prioD = { pattern = "^%(D%)", group = "Special" },
    prioE = { pattern = "^%(E%)", group = "Normal" },
  },
}

vim.keymap.set("n", ",s", "<Cmd>w | %sort | w | lua vim.notify('sorted')<CR>", { buffer = 0, desc = "Sort" })

local insert_new_todo = function()
  local win = vim.api.nvim_get_current_win()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(win))
  local current_date = os.date("%Y-%m-%d")
  vim.api.nvim_buf_set_lines(0, row, row, false, { "(A) " .. current_date .. " EDIT_ME @work" })

  local newRow = row + 1
  local newCol = 15

  vim.api.nvim_win_set_cursor(win, { newRow, newCol })
end
vim.keymap.set("n", ",,", insert_new_todo, { buffer = 0, desc = "Create todo" })
