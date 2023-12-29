return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },

  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {},
        ["core.qol.toc"] = {},
        ["core.qol.todo_items"] = {},
        ["core.looking-glass"] = {},
        ["core.export"] = {},
        ["core.export.markdown"] = { config = { extensions = "all" } },
        ["core.tangle"] = { config = { report_on_empty = false } },

        -- Completion
        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
            name = "[Norg]",
          },
        },
        ["core.integrations.nvim-cmp"] = {},

        -- Concealer
        ["core.concealer"] = {
          config = {
            icons = {
              todo = {
                undone = { icon = "" },
              },
            },
          },
        },

        -- Keybindings
        ["core.keybinds"] = {
          -- https://github.com/nvim-neorg/neorg/wiki/User-Keybinds
          config = {
            default_keybinds = true,
            neorg_leader = "<LocalLeader>",
          },
        },

        -- Workspaces
        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = "~/Syncthing/SYNC_STUFF/neorg",
            },
            default_workspace = "notes",
          },
        },

        -- Telescope
        ["core.integrations.telescope"] = {},
      },
    })

    vim.wo.conceallevel = 2

    local map = vim.keymap.set
    map("n", "<leader>nn", "<cmd>Neorg<cr>", { desc = "Neorg" })
  end,
}
