return {
  "folke/which-key.nvim",
  event = "VeryLazy",

  opts = {
    preset = "helix",
    spec = {
      {
        mode = { "n", "v" },
        -- { "<leader>c", group = "code" },
        -- { "<leader>d", group = "debug" },
        { "<leader>f", group = "file/find" },
        { "<leader>g", group = "git" },
        { "<leader>l", group = "lsp", icon = { icon = "⚡", color = "red" } },
        -- { "<leader>gh", group = "hunks" },
        { "<leader>s", group = "search" },
        { "<leader>u", group = "ui", icon = { icon = "󰙵 ", color = "cyan" } },
        { "<leader>x", group = "diagnostics/quickfix", icon = { icon = "󱖫 ", color = "green" } },
        { "g", group = "goto" },
        -- { "gs", group = "surround" },
        { "z", group = "fold" },
        {
          "<leader>b",
          group = "buffer",
          expand = function() return require("which-key.extras").expand.buf() end,
        },
        {
          "<leader>w",
          group = "windows",
          proxy = "<c-w>",
          expand = function() return require("which-key.extras").expand.win() end,
        },
        -- better descriptions
        { "gx", desc = "Open with system app" },
      },
    },
  },

  keys = {
    {
      "<leader>?",
      function() require("which-key").show({ global = false }) end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
}
