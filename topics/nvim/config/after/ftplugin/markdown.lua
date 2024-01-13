local A = vim.api
local my_au = A.nvim_create_augroup("AORITH_MD", { clear = true })

vim.opt_local.colorcolumn = "0"
vim.opt_local.conceallevel = 2
vim.opt_local.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt_local.foldmethod = "expr"
vim.opt_local.foldlevel = 99
vim.opt_local.wrap = true

-- Inserts a new empty code block below the current line
local function insertCodeBlock()
  local win = vim.api.nvim_get_current_win()
  local row, _ = unpack(vim.api.nvim_win_get_cursor(win))

  -- Insert the text in a new line below the current line
  vim.api.nvim_buf_set_lines(0, row, row, false, { "```", "```" })

  local newRow = row + 1 -- Move cursor down one line
  local newCol = 4

  vim.api.nvim_win_set_cursor(win, { newRow, newCol })
end

-- Navigate between links / headers
local function MdLinks()
  if vim.fn.search("\\(](.\\+)\\|^# .\\+\\|\\[\\[.\\+]]\\)", "w") ~= 0 then
    vim.cmd("norm w")
  else
    vim.notify("No markdown headers or links found.")
  end
end
local function MdLinksBack()
  if vim.fn.search("\\(](.\\+)\\|^# .\\+\\|\\[\\[.\\+]]\\)", "b") ~= 0 then
    -- I have to search twice backwards because the cursor is moved
    -- with 'w' and the backward search finds the same item
    vim.fn.search("\\(](.\\+)\\|^# .\\+\\|\\[\\[.\\+]]\\)", "b")
    vim.cmd("norm w")
  else
    vim.notify("No markdown headers or links found.")
  end
end

-- Toggle To-Dos
local function ToDoToggle()
  -- In lua '%' are escape chars
  if string.match(vim.api.nvim_get_current_line(), "- %[ %] ") ~= nil then
    vim.cmd([[
      s/- \[ \] /- \[x\] /g
      nohl
    ]])
  elseif string.match(vim.api.nvim_get_current_line(), "- %[[xX]%] ") ~= nil then
    vim.cmd([[
      s/- \[[xX]\] /- \[ \] /g
      nohl
      ]])
  end
end

-- Mappings
map("n", "<TAB>", MdLinks, { buffer = 0, desc = "Next header or link" })
map("n", "<S-TAB>", MdLinksBack, { buffer = 0, desc = "Prev header or link" })
map("n", "<LocalLeader>c", insertCodeBlock, { buffer = 0, desc = "Insert code block" })
map("n", "tt", ToDoToggle, { buffer = 0, desc = "Toggle To-Do" })
map("n", "<CR>", vim.lsp.buf.definition, { buffer = 0, desc = "Follow link (go to definition)" })

-- Switch to the current directory of the file if it's a note
A.nvim_create_autocmd("BufWinEnter", {
  group = my_au,
  pattern = "*.md",
  callback = function()
    if string.find(vim.api.nvim_buf_get_name(0), "/SYNC_STUFF/") then vim.cmd("cd %:p:h") end
  end,
})

-- Highlight markdown 'tags'
---@diagnostic disable-next-line: inject-field
vim.b.minihipatterns_config = {
  highlighters = {
    mdtags = { pattern = "()#%w+()", group = "Special" },
  },
}
