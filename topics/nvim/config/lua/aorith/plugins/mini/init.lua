return {
  "echasnovski/mini.nvim",
  version = "*",

  config = function()
    require("mini.bufremove").setup()
    require("mini.trailspace").setup()
    require("mini.misc").setup()
    require("mini.comment").setup()

    require("aorith.plugins.mini.statusline").setup()
    require("aorith.plugins.mini.hipatterns").setup()
    require("aorith.plugins.mini.clue").setup()

    local map = vim.keymap.set

    map("n", "<leader>q", function() MiniBufremove.delete() end, { desc = "Delete current buffer" })
    map("n", "<leader>z", function() MiniMisc.zoom() end, { desc = "Zoom window" })
  end,
}
