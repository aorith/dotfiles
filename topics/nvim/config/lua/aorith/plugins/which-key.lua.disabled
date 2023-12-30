return {
  "folke/which-key.nvim",
  enabled = false,
  event = "VeryLazy",
  config = function()
    local wk = require("which-key")
    wk.setup({ plugins = { spelling = true } })

    local keymaps = {
      mode = { "n", "v" },
      ["<leader>b"] = { name = "+buffers" },
      ["<leader>f"] = { name = "+file/find" },
      ["<leader>g"] = { name = "+git" },
      ["<leader>gh"] = { name = "+hunks" },
      ["<leader>l"] = { name = "+lsp" },
      ["<leader>s"] = { name = "+search" },
      ["<leader>u"] = { name = "+ui" },
      ["<leader>w"] = { name = "+windows" },
      ["<leader>x"] = { name = "+diagnostics/quickfix" },
    }
    wk.register(keymaps)
  end,
}
