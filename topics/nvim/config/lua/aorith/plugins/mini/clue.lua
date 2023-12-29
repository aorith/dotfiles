local M = {}

M.setup = function()
  local miniclue = require("mini.clue")
  miniclue.setup({
    window = {
      delay = 250,

      config = {
        -- Position
        anchor = "SW",
        row = "auto",
        col = "auto",

        -- Compute window width automatically
        -- width = "auto",

        -- Use double-line border
        border = "double",
      },
    },

    triggers = {
      -- Leader triggers
      { mode = "n", keys = "<Leader>" },
      { mode = "x", keys = "<Leader>" },
      -- Local leader
      { mode = "n", keys = "<LocalLeader>" },
      { mode = "x", keys = "<LocalLeader>" },

      -- Built-in completionmini
      { mode = "i", keys = "<C-x>" },

      -- `g` key
      { mode = "n", keys = "g" },
      { mode = "x", keys = "g" },

      -- Marks
      { mode = "n", keys = "'" },
      { mode = "n", keys = "`" },
      { mode = "x", keys = "'" },
      { mode = "x", keys = "`" },

      -- Registers
      { mode = "n", keys = '"' },
      { mode = "x", keys = '"' },
      { mode = "i", keys = "<C-r>" },
      { mode = "c", keys = "<C-r>" },

      -- Window commands
      { mode = "n", keys = "<C-w>" },

      -- `z` key
      { mode = "n", keys = "z" },
      { mode = "x", keys = "z" },
    },

    clues = {
      miniclue.gen_clues.builtin_completion(),
      miniclue.gen_clues.g(),
      miniclue.gen_clues.marks(),
      miniclue.gen_clues.registers(),
      miniclue.gen_clues.windows(),
      miniclue.gen_clues.z(),

      { mode = "n", keys = "<leader>b", desc = "+buffers" },
      { mode = "n", keys = "<leader>f", desc = "+file/find" },
      { mode = "n", keys = "<leader>g", desc = "+git" },
      { mode = "n", keys = "<leader>gh", desc = "+hunks" },
      { mode = "n", keys = "<leader>l", desc = "+lsp" },
      { mode = "n", keys = "<leader>s", desc = "+search" },
      { mode = "n", keys = "<leader>u", desc = "+ui" },
      { mode = "n", keys = "<leader>w", desc = "+windows" },
      { mode = "n", keys = "<leader>x", desc = "+diagnostics/quickfix" },
      { mode = "n", keys = "<leader>n", desc = "+neorg" },
    },
  })
end

return M
