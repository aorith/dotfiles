return {
  { "mbbill/undotree", keys = {
    { "<leader>U", "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
  } },

  { "varnishcache-friends/vim-varnish" },

  {
    "ojroques/nvim-osc52",
    config = function()
      vim.keymap.set("n", "<leader>c", require("osc52").copy_operator, { expr = true, desc = "Osc52 copy operator" })
      vim.keymap.set("x", "<leader>y", require("osc52").copy_visual, { desc = "Osc52 copy visual selection" })
      -- this remap doesn't work inside of lazy keys table
      vim.keymap.set("n", "<leader>y", "<leader>c_", { remap = true, desc = "Osc52 copy current line" })
    end,
  },
}
