local map = vim.keymap.set
local fl = require("fzf-lua")

fl.setup({
  winopts = {
    -- preview = { default = "bat" },
  },

  previewers = {
    bat = {
      theme = "ansi",
    },
  },

  files = {
    --rg_opts = "--color=never --files --hidden --follow -g '!.git' -g '!.venv' -g '!venv'",
    --fd_opts = "--color=never --type f --hidden --follow --exclude .git --exclude venv --exclude .venv",
    rg_opts = "--color=never --files --follow -g '!.git' -g '!.venv' -g '!venv'",
    fd_opts = "--color=never --type f --follow --exclude .git --exclude venv --exclude .venv",
    git_icons = false,
  },

  buffers = {
    file_icons = true,
  },
})

map("n", "<leader><space>", function() fl.buffers() end, { desc = "Switch Buffer" })

map("n", "<leader>ff", function() fl.files() end, { desc = "Find Files" })

map("n", "<leader>fg", function() fl.live_grep_native() end, { desc = "Live Grep" })

map("n", "<leader>fm", function() fl.marks() end, { desc = "Marks" })

map("n", "<leader>sd", function() fl.diagnostics_document() end, { desc = "Diagnostics Document" })

map("n", "<leader>sD", function() fl.diagnostics_workspace() end, { desc = "Diagnostics Workspace" })

map(
  "n",
  "<leader>uc",
  function() fl.colorschemes({ winopts = { height = 0.33, width = 0.33 } }) end,
  { desc = "Colorschemes" }
)

-- Completion
map({ "n", "v", "i" }, "<C-x><C-f>", function() fl.complete_path() end, { silent = true, desc = "Fuzzy complete path" })
