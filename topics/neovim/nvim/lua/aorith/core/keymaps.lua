local utils = require("aorith.core.utils")

-- Create `<Leader>` mappings
local nmap_leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set("n", "<Leader>" .. suffix, rhs, opts)
end
local xmap_leader = function(suffix, rhs, desc, opts)
  opts = opts or {}
  opts.desc = desc
  vim.keymap.set("x", "<Leader>" .. suffix, rhs, opts)
end

-- Copy to primary selection on select
map("v", "<LeftRelease>", '"*ygv')

-- Misc
map("n", "x", '"_x', { desc = "Avoid 'x' copying to the register" })
map("v", "<leader>y", '"+y', { remap = true, desc = "Copy to the system clipboard" })
map("n", "<leader>y", '"+yy', { remap = true, desc = "Copy to the system clipboard" })

-- Moves lines
map("v", "J", ":m '>+1<CR>gv=gv")
map("v", "K", ":m '<-2<CR>gv=gv")

-- Navigate wrapped lines
map("n", "j", "gj")
map("n", "k", "gk")

-- Center view on search
map("n", "n", "nzz")
map("n", "N", "Nzz")

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

-- Don't reset indent on '#', see :h smartindent
map("i", "#", "X#")

-- Get highlight group under cursor
map("n", "<C-e>", function()
  local result = vim.treesitter.get_captures_at_cursor(0)
  print(vim.inspect(result))
end, { desc = "highlight group under cursor" })

map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- buffers
map("n", "<leader><TAB>", "<cmd>bnext<CR>", { silent = true, desc = "Next buffer" })
map("n", "<leader>ba", "<cmd>b#<cr>", { desc = "Alternate buffer" })
map("n", "<leader>bd", "<Cmd>lua MiniBufremove.delete()<CR>", { desc = "Delete" })
map("n", "<leader>bD", "<Cmd>lua MiniBufremove.delete(0, true)<CR>", { desc = "Delete!" })
map("n", "<leader>bw", "<Cmd>lua MiniBufremove.wipeout()<CR>", { desc = "Wipeout" })
map("n", "<leader>bW", "<Cmd>lua MiniBufremove.wipeout(0, true)<CR>", { desc = "Wipeout!" })
map("n", "<leader>bb", function()
  local curbufnr = vim.api.nvim_get_current_buf()
  local bufinfo
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if bufnr ~= curbufnr and vim.api.nvim_get_option_value("modified", { buf = bufnr }) == false then
      bufinfo = vim.fn.getbufinfo(bufnr)[1]
      if bufinfo.loaded == 1 and bufinfo.listed == 1 then vim.cmd("bd! " .. tostring(bufnr)) end
    end
  end
end, { desc = "Close all other unmodified buffers" })

-- windows
map("n", "<leader>w", "<C-W>c", { desc = "Delete window" })
map("n", "<leader>-", "<C-W>s", { desc = "Split window below" })
map("n", "<leader>|", "<C-W>v", { desc = "Split window right" })

-- others
map("", "<F1>", "<nop>") -- "" == map
map("!", "<F1>", "<nop>") -- "!" == map!
vim.api.nvim_create_user_command("W", "w", { bang = true })
vim.api.nvim_create_user_command("Q", "q", { bang = true })

-- terminal
map("t", "<Esc>", "<C-\\><C-n>", { desc = "Go to normal mode" })
map("n", "<F1>", "<cmd>split<bar>terminal<cr>", { desc = "Terminal" })

--- LSP
-- having the keymaps outside of the 'on_attach' lsp allows to use them even if
-- no lsp server is attached, useful for null-ls and I prefer the keymap to fail than to not exist

-- Show active LSP clients
map("n", "<leader>la", function() utils.show_in_popup(utils.get_active_lsp_clients(), "markdown") end, { desc = "Get active LSP clients" })

-- quick fix
map("n", "<leader>j", "<cmd>cnext<CR>", { desc = "Next item in QuickFix" })
map("n", "<leader>k", "<cmd>cprevious<CR>", { desc = "Previous item in QuickFix" })

-- diagnostics
map("n", "<leader>ll", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<leader>lq", vim.diagnostic.setloclist, { desc = "Set Loc List" })
map("n", "<leader>lj", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
map("n", "<leader>lk", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })

map("n", "<leader>lc", vim.lsp.buf.code_action, { desc = "Code actions" })
map("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>ls", vim.lsp.buf.signature_help, { desc = "Signature" })

-- without leader key
map("n", "K", vim.lsp.buf.hover, { desc = "Hover Documentation" })

nmap_leader("<leader>", "<Cmd>Pick buffers include_current=false<CR>", "Buffers")
nmap_leader("ff", "<Cmd>Pick files<CR>", "Files")
nmap_leader("fg", "<Cmd>Pick grep_live<CR>", "Grep live")
nmap_leader("fl", '<Cmd>Pick buf_lines scope="all"<CR>', "Lines (all)")
nmap_leader("fL", '<Cmd>Pick buf_lines scope="current"<CR>', "Lines (current)")
nmap_leader("fd", '<Cmd>Pick diagnostic scope="all"<CR>', "Diagnostic workspace")
nmap_leader("fD", '<Cmd>Pick diagnostic scope="current"<CR>', "Diagnostic buffer")
nmap_leader("fm", "<Cmd>Pick git_hunks<CR>", "Modified hunks (all)")
nmap_leader("fM", '<Cmd>Pick git_hunks path="%:p"<CR>', "Modified hunks (current)")
nmap_leader("fr", "<Cmd>Pick resume<CR>", "Resume")
nmap_leader("fR", '<Cmd>Pick lsp scope="references"<CR>', "References (LSP)")
nmap_leader("fs", '<Cmd>Pick lsp scope="document_symbol"<CR>', "Symbols buffer (LSP)")
nmap_leader("fS", '<Cmd>Pick lsp scope="workspace_symbol"<CR>', "Symbols workspace (LSP)")
nmap_leader("fh", "<Cmd>Pick help<CR>", "Help tags")
nmap_leader("fH", "<Cmd>Pick hl_groups<CR>", "Highlight groups")
nmap_leader("fp", [[<Cmd>Pick spellsuggest<CR>]], "Spell suggest")
nmap_leader("fk", [[<Cmd>Pick keymaps<CR>]], "Keymaps")
nmap_leader("fc", '<Cmd>Pick git_commits path="%:p"<CR>', "Commits (current)")
nmap_leader("fC", "<Cmd>Pick git_commits<CR>", "Commits (all)")

local git_log_cmd = [[Git log --pretty=format:\%h\ \%as\ │\ \%s --topo-order]]
nmap_leader("ga", "<Cmd>Git diff --cached<CR>", "Added diff")
nmap_leader("gA", "<Cmd>Git diff --cached -- %:p<CR>", "Added diff buffer")
nmap_leader("gc", "<Cmd>Git commit<CR>", "Commit")
nmap_leader("gC", "<Cmd>Git commit --amend<CR>", "Commit amend")
nmap_leader("gd", "<Cmd>Git diff -- %:p<CR>", "Diff buffer")
nmap_leader("gD", "<Cmd>Git diff<CR>", "Diff")
nmap_leader("gg", "<Cmd>terminal lazygit<CR>", "Log buffer")
nmap_leader("gl", "<Cmd>" .. git_log_cmd .. " --follow -- %:p<CR>", "Log buffer")
nmap_leader("gL", "<Cmd>" .. git_log_cmd .. "<CR>", "Log")
nmap_leader("go", "<Cmd>lua MiniDiff.toggle_overlay()<CR>", "Toggle overlay")
nmap_leader("gs", "<Cmd>lua MiniGit.show_at_cursor()<CR>", "Show at cursor")

xmap_leader("gs", "<Cmd>lua MiniGit.show_at_cursor()<CR>", "Show at selection")

-- LSP
map("n", "gd", "<Cmd>Pick lsp scope='definition'<CR>", { desc = "Definitions" })
map("n", "gD", "<Cmd>Pick lsp scope='declaration'<CR>", { desc = "Declaration" })
map("n", "gr", "<Cmd>Pick lsp scope='references'<CR>", { desc = "References" })
map("n", "gI", "<Cmd>Pick lsp scope='implementation'<CR>", { desc = "Implementation" })
map("n", "gy", "<Cmd>Pick lsp scope='type_definition'<CR>", { desc = "Type Definitions" })
