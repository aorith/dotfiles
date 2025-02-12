return {
  "echasnovski/mini.nvim",
  version = false,
  lazy = false,
  priority = 500,

  config = function()
    require("mini.icons").setup()
    require("mini.icons").mock_nvim_web_devicons()
    require("aorith.plugins.mini.notify").setup()

    require("mini.extra").setup()
    require("mini.diff").setup()
    require("mini.git").setup()
    require("mini.ai").setup() -- Enables 'ciq' (change inside quotes) or 'cib' (change inside brackets), etc.
    require("mini.indentscope").setup()
    require("mini.misc").setup()
    require("mini.animate").setup({
      cursor = { enable = true },
      resize = { enable = false },
    })

    -- sa => surround around
    -- sd => surround delete
    -- sr => surround replace
    -- Example: Visual select a word -> sa"  (surround around quotes, 'saq' with mini.ai)
    require("mini.surround").setup()

    require("mini.tabline").setup()
    require("aorith.plugins.mini.statusline").setup()

    require("aorith.plugins.mini.pick").setup()
    require("aorith.plugins.mini.files").setup()
    require("aorith.plugins.mini.hipatterns").setup()
    require("aorith.plugins.mini.clue").setup()

    map("n", "<leader>q", function() require("mini.bufremove").delete() end, { desc = "Delete current buffer" })
    map("n", "<leader>z", function() MiniMisc.zoom() end, { desc = "Zoom window" })
    map("n", "<leader>go", function() require("mini.diff").toggle_overlay(0) end, { desc = "Toggle diff overlay" })
  end,
}
