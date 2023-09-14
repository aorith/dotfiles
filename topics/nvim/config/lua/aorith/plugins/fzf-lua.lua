return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "FzfLua",

  keys = {
    { "<leader><space>", "<cmd>lua require('fzf-lua').buffers()<cr>", mode = "n", desc = "Switch Buffer" },
    { "<leader>ff", "<cmd>lua require('fzf-lua').files()<cr>", mode = "n", desc = "Find Files" },
    { "<leader>fg", "<cmd>lua require('fzf-lua').live_grep()<cr>", mode = "n", desc = "Live Grep" },
  },
}
