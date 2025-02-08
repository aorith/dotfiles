return {
  "echasnovski/mini.nvim",
  version = false,

  config = function()
    require("mini.icons").setup()
    require("mini.icons").mock_nvim_web_devicons()

    require("mini.extra").setup()
    require("mini.diff").setup()
    require("mini.git").setup()
    require("mini.ai").setup() -- Enables 'ciq' (change inside quotes) or 'cib' (change inside brackets), etc.

    -- sa => surround around
    -- sd => surround delete
    -- sr => surround replace
    -- Example: Visual select a word -> sa"  (surround around quotes, 'saq' with mini.ai)
    require("mini.surround").setup()

    require("mini.tabline").setup({})

    -- require("aorith.plugins.mini.statusline").setup()
    require("aorith.plugins.mini.files").setup()
    require("aorith.plugins.mini.hipatterns").setup()

    map("n", "<leader>q", function() require("mini.bufremove").delete() end, { desc = "Delete current buffer" })
    map("n", "<leader>go", function() require("mini.diff").toggle_overlay(0) end, { desc = "Toggle diff overlay" })
  end,
}
