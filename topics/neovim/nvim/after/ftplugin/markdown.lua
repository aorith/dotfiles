vim.bo.textwidth = 0

vim.wo.spell = true
vim.wo.conceallevel = 0
vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
vim.wo.foldmethod = "expr"
vim.wo.foldlevel = 99
vim.wo.wrap = true
vim.wo.breakindent = true

---@diagnostic disable-next-line: inject-field
vim.b.minihipatterns_config = {
  highlighters = {
    -- Highlight markdown 'tags'
    mdtags = { pattern = "%f[#]()#%w+", group = "Special" },
  },
}

-- Mappings
local utils = require("aorith.core.utils")
local lmap = function(key, f, desc) vim.keymap.set("n", key, f, { buffer = 0, desc = desc }) end

lmap("<TAB>", utils.markdown_next_link, "Next header or link")
lmap("<S-TAB>", utils.markdown_prev_link, "Prev header or link")
lmap("<LocalLeader>c", utils.markdown_insert_codeblock, "Insert code block")
lmap("tt", utils.markdown_todo_toggle, "Toggle checkbox")
