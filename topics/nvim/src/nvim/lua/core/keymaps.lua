local get_active_lsp_clients = function()
  local servers = " Active LSP servers:\n"
  for _, c in pairs(vim.lsp.buf_get_clients()) do
    servers = servers .. "\n  " .. c.name
  end
  return servers
end

local map = vim.keymap.set

-- Toggles
map("n", "<leader>us", function()
  require("core.utils").toggle("spell")
end, { desc = "Toggle Spelling" })

map("n", "<leader>uw", function()
  require("core.utils").toggle("wrap")
end, { desc = "Toggle Word Wrap" })

map("n", "<leader>uL", function()
  require("core.utils").toggle("relativenumber", true)
  require("core.utils").toggle("number")
end, { desc = "Toggle Line Numbers" })

map("n", "<leader>ud", require("core.utils").toggle_diagnostics, { desc = "Toggle Diagnostics" })
map("n", "<leader>ul", require("core.utils").toggle_complete_listchars, { desc = "Toggle ListChars" })

local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
map("n", "<leader>uc", function()
  require("core.utils").toggle("conceallevel", false, { 0, conceallevel })
end, { desc = "Toggle Conceal" })

-- Show active LSP clients
map("n", "<leader>la", function()
  require("lazy.util").info(get_active_lsp_clients())
end, { desc = "Get active LSP clients" })

-- Misc
map("n", "x", '"_x', { desc = "Avoid 'x' copying to the register" })

-- Move to window using the <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })
-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Clear search with <esc>
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Get highlight group under cursor
map("n", "<C-e>", function()
  local result = vim.treesitter.get_captures_at_cursor(0)
  print(vim.inspect(result))
end, { desc = "highlight group under cursor" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- highlights under cursor
if vim.fn.has("nvim-0.9.0") == 1 then
  map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
end

-- windows
map("n", "<leader>ww", "<C-W>p", { desc = "Other window" })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>w-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>w|", "<C-W>v", { desc = "Split window right" })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right" })
