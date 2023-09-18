local map = vim.keymap.set

require("fzf-lua").setup({
  files = {
    --rg_opts = "--color=never --files --hidden --follow -g '!.git' -g '!.venv' -g '!venv'",
    --fd_opts = "--color=never --type f --hidden --follow --exclude .git --exclude venv --exclude .venv",
    rg_opts = "--color=never --files --follow -g '!.git' -g '!.venv' -g '!venv'",
    fd_opts = "--color=never --type f --follow --exclude .git --exclude venv --exclude .venv",
  },
})

map("n", "<leader><space>", "<cmd>lua require('fzf-lua').buffers()<cr>", { desc = "Switch Buffer" })
map("n", "<leader>ff", "<cmd>lua require('fzf-lua').files()<cr>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>lua require('fzf-lua').live_grep()<cr>", { desc = "Live Grep" })
map("n", "<leader>fm", "<cmd>lua require('fzf-lua').marks()<cr>", { desc = "Marks" })

map("n", "<leader>sd", "<cmd>FzfLua diagnostics_document<cr>", { desc = "Diagnostics Document" })
map("n", "<leader>sD", "<cmd>FzfLua diagnostics_workspace<cr>", { desc = "Diagnostics Workspace" })

map("n", "<leader>uc", "<cmd>FzfLua colorschemes<cr>", { desc = "Colorschemes" })
