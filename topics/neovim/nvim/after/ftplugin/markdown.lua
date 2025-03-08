vim.bo.textwidth = 0

vim.wo[0][0].number = false
vim.wo[0][0].signcolumn = "auto"
vim.wo[0][0].spell = true
vim.wo[0][0].conceallevel = 0
vim.wo[0][0].foldexpr = "nvim_treesitter#foldexpr()"
vim.wo[0][0].foldmethod = "expr"
vim.wo[0][0].foldlevel = 99
vim.wo[0][0].wrap = true
vim.wo[0][0].breakindent = true

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
