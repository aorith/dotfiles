local _M = {}

function _M.setup()
	local km = vim.keymap
	km.set("n", "<leader><TAB>", "<cmd>bnext<CR>")

	-- osc52 copy
	km.set("n", "<leader>c", require("osc52").copy_operator, { expr = true })
	km.set("x", "<leader>y", require("osc52").copy_visual)
	km.set("n", "<leader>y", "<leader>c_", { remap = true }) -- copy current line

	km.set("n", "<leader>/", "<cmd>nohl<CR>")
	-- avoid 'x' copying to the register
	km.set("n", "x", '"_x')

	-- Neotree
	km.set("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "File Explorer" })

	-- Telescope
	km.set("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Buffers" })
	km.set("n", "<leader>fd", "<cmd>Telescope diagnostics<CR>", { desc = "Find diagnostics" })
	km.set("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Find files" })
	km.set("n", "<leader>fG", "<cmd>Telescope live_grep<CR>", { desc = "Grep all" })
	km.set("n", "<leader>fg", "<cmd>Telescope current_buffer_fuzzy_find<CR>", { desc = "Grep buffer" })

	-- Git
	km.set("n", "<leader>gb", "<cmd>Gitsigns toggle_current_line_blame<CR>", { desc = "Toggle blame" })
	km.set("n", "<leader>gw", "<cmd>Gitsigns toggle_word_diff<CR>", { desc = "Toggle word diff" })
end

function _M.lsp_keymaps(bufnr)
	local keymap = function(mode, map, cmd, desc)
		local bufopts = { noremap = true, silent = true, buffer = bufnr, desc = desc }
		vim.keymap.set(mode, map, cmd, bufopts)
	end

	keymap("n", "<leader>lc", vim.lsp.buf.code_action, "Code actions")
	keymap("n", "<leader>lf", vim.lsp.buf.format, "Format")
	keymap("n", "<leader>lh", vim.lsp.buf.hover, "Hover")
	keymap("n", "<leader>ll", vim.diagnostic.open_float, "Line diagnostics")
	keymap("n", "<leader>lq", vim.diagnostic.setloclist, "Set Loc List")
	keymap("n", "<leader>lj", vim.diagnostic.goto_next, "Next diagnostic")
	keymap("n", "<leader>lk", vim.diagnostic.goto_prev, "Prev diagnostic")
	keymap("n", "<leader>lr", vim.lsp.buf.rename, "Rename")
	keymap("n", "<leader>ls", vim.lsp.buf.signature_help, "Signature")

	-- Go to
	keymap("n", "<leader>lgc", vim.lsp.buf.declaration, "Declaration")
	keymap("n", "<leader>lgd", vim.lsp.buf.definition, "Definition")
	keymap("n", "<leader>lgi", vim.lsp.buf.implementation, "Implementation")
	keymap("n", "<leader>lgr", vim.lsp.buf.references, "References")
	keymap("n", "<leader>lgt", vim.lsp.buf.type_definition, "Type definitions")
end

return _M
