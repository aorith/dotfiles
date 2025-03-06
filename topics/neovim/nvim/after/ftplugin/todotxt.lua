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

local insert_new_todo = function()
  local win = vim.api.nvim_get_current_win()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(win))
  local date = os.date("%Y-%m-%d")
  vim.api.nvim_buf_set_lines(0, row, row, false, { "(A) " .. date .. " EDIT_ME @work" })

  local newRow = row + 1
  local newCol = 15

  vim.api.nvim_win_set_cursor(win, { newRow, newCol })
end

local toggle_todo_state = function()
  local node = vim.treesitter.get_node()
  if not node then return end

  local start_row, _ = node:range()
  local line = vim.fn.getline(start_row + 1)
  local pattern = "^x %d%d%d%d%-%d%d%-%d%d "

  if line:match(pattern) then
    line = line:gsub(pattern, "")
  else
    local date = os.date("%Y-%m-%d")
    line = "x " .. date .. " " .. line
  end

  vim.fn.setline(start_row + 1, line)
end

local cycle_priority = function()
  local node = vim.treesitter.get_node()
  if not node then return end

  local start_row, _ = node:range()
  local line = vim.fn.getline(start_row + 1)

  if line:match("^x") then
    vim.notify("Cannot cycle priority of tasks marked as done")
    return
  end

  local current_priority = line:match("^%((%a)%)")

  local priority_map = { A = "(B) ", B = "(C) ", C = "(D) ", D = "(E) ", E = "(A) " }
  local new_priority = priority_map[current_priority] or "(A)"

  if current_priority then
    line = line:gsub("^%(%a%)%s*", new_priority)
  else
    line = new_priority .. " " .. line
  end

  vim.fn.setline(start_row + 1, line)
end

if vim.fn.expand("%:t") == "done.txt" then
  vim.keymap.set("n", ",s", "<Cmd>w | %sort! | w | lua vim.notify('sorted')<CR>", { buffer = 0, desc = "Sort reverse" })
else
  vim.keymap.set("n", ",s", "<Cmd>w | %sort | w | lua vim.notify('sorted')<CR>", { buffer = 0, desc = "Sort" })
end
vim.keymap.set("n", ",,", insert_new_todo, { buffer = 0, desc = "Create todo" })
vim.keymap.set("n", ",d", toggle_todo_state, { buffer = 0, desc = "Toggle todo state" })
vim.keymap.set("n", ",a", cycle_priority, { buffer = 0, desc = "Cycle priority" })
