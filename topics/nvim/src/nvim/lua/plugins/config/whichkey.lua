local wk = require("which-key")
wk.setup({})

wk.register({
	g = {
		name = "GIT",
	},
	f = {
		name = "TELESCOPE",
	},
	l = {
		name = "LSP",
		g = {
			name = "GO TO",
		},
	},
}, {
	prefix = "<leader>",
})
