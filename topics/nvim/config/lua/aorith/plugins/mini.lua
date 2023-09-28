local map = vim.keymap.set

require("mini.bufremove").setup()
require("mini.trailspace").setup()
require("mini.misc").setup()
require("mini.comment").setup()

require("aorith.plugins.mini.files")
--require("aorith.plugins.mini.statusline")
require("aorith.plugins.mini.hipatterns")
require("aorith.plugins.mini.clue")
--require("aorith.plugins.mini.completion").setup()

map("n", "<leader>q", function() MiniBufremove.delete() end, { desc = "Delete current buffer" })
map("n", "<leader>q", function() MiniBufremove.delete(nil, true) end, { desc = "Force delete current buffer" })
map("n", "-", function() MiniFiles.open() end, { desc = "MiniFiles" })
map("n", "<leader>z", function() MiniMisc.zoom() end, { desc = "Zoom window" })
