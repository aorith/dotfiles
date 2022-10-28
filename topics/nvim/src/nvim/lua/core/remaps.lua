local km = vim.keymap

km.set("n", "<leader><TAB>", "<cmd>bnext<CR>")
km.set("v", "<leader>y", require("osc52").copy_visual)
km.set("n", "<leader>/", "<cmd>nohl<CR>")
-- avoid 'x' copying to the register
km.set("n", "x", '"_x')
