local wk = require("which-key")
wk.setup({})

wk.register({
	e = { "<cmd>Neotree toggle<CR>", "FileExplorer" },
	g = {
		name = "GIT",
		b = { "<cmd>Gitsigns toggle_current_line_blame<CR>", "Blame lines" },
		w = { "<cmd>Gitsigns toggle_word_diff<CR>", "Word diff" },
	},
	f = {
		name = "TELESCOPE",
		b = { "<cmd>Telescope buffers<CR>", "Buffers" },
		d = { "<cmd>Telescope diagnostics<CR>", "Find Diagnostics" },
		f = { "<cmd>Telescope find_files<CR>", "Find Files" },
		g = { "<cmd>Telescope live_grep<CR>", "Live Grep" },
		l = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Fuzzy find in current Buffer" },
	},
	l = {
		name = "LSP",
		c = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Show code actions" },
		f = { "<cmd>lua vim.lsp.buf.format { async = false }<CR>", "Format" },
		h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Info" },
		j = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Go to next diagnostic" },
		k = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Go to previous diagnostic" },
		l = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Show line diagnostics" },
		r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
		d = {
			name = "DEFINITIONS",
			c = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
			d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Definition" },
			i = { "<cmd>lua vim.lsp.buf.implementation()<CR>", "Implementation" },
			r = { "<cmd>lua vim.lsp.buf.references()<CR>", "Find references" },
			t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Get type definition" },
		},
	},
}, {
	prefix = "<leader>",
})
