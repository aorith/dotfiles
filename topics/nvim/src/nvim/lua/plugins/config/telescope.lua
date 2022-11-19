local actions = require("telescope.actions")

require("telescope").load_extension("fzf")

require("telescope").setup({
	defaults = {
		path_display = { "truncate" },
		sorting_strategy = "ascending",
		file_ignore_patterns = { "venv", "__pycache__" },
		layout_config = {
			horizontal = {
				prompt_position = "top",
			},
			vertical = {
				mirror = false,
			},
		},
		mappings = {
			i = {
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
})
