return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    use_diagnostic_signs = true,
  },

  keys = {
    { "<leader>xx", "<cmd>TroubleToggle document_diagnostics<cr>", mode = "n", desc = "Document Diagnostics" },
    { "<leader>xX", "<cmd>TroubleToggle workspace_diagnostics<cr>", mode = "n", desc = "Workspace Diagnostics" },
    { "<leader>xL", "<cmd>TroubleToggle loclist<cr>", mode = "n", desc = "Location List (Trouble)" },
    { "<leader>xQ", "<cmd>TroubleToggle quickfix<cr>", mode = "n", desc = "Quickfix List (Trouble)" },
  },
}
