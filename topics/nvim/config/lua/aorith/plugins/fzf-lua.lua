return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "FzfLua",

  opts = {
    files = {
      --rg_opts = "--color=never --files --hidden --follow -g '!.git' -g '!.venv' -g '!venv'",
      --fd_opts = "--color=never --type f --hidden --follow --exclude .git --exclude venv --exclude .venv",
      rg_opts = "--color=never --files --follow -g '!.git' -g '!.venv' -g '!venv'",
      fd_opts = "--color=never --type f --follow --exclude .git --exclude venv --exclude .venv",
    },
  },

  keys = {
    { "<leader><space>", "<cmd>lua require('fzf-lua').buffers()<cr>", mode = "n", desc = "Switch Buffer" },
    { "<leader>ff", "<cmd>lua require('fzf-lua').files()<cr>", mode = "n", desc = "Find Files" },
    { "<leader>fg", "<cmd>lua require('fzf-lua').live_grep()<cr>", mode = "n", desc = "Live Grep" },
    { "<leader>fm", "<cmd>lua require('fzf-lua').marks()<cr>", mode = "n", desc = "Marks" },
  },
}
