local enabled = false
local notes_dir = "~/Syncthing/SYNC_STUFF/notes/main"

if enabled then
  -- Global keymaps
  map("n", "<leader>nn", "<cmd>Neorg<cr>", { desc = "Neorg" })
  map("n", "<leader>nf", function() require("telescope.builtin").find_files({ cwd = notes_dir }) end, { desc = "Find" })
  map(
    "n",
    "<leader>ng",
    function() require("telescope.builtin").live_grep({ cwd = notes_dir, layout_strategy = "horizontal" }) end,
    { desc = "Grep ALL" }
  )
end

return {
  --dir = "/home/aorith/githome/01_UPSTREAM/neorg",
  "nvim-neorg/neorg",
  version = "*",
  enabled = enabled,
  build = ":Neorg sync-parsers",
  dependencies = { "nvim-lua/plenary.nvim" },
  lazy = true,
  cmd = "Neorg",
  ft = "norg",
  config = function()
    require("neorg").setup({
      load = {
        ["core.defaults"] = {},

        ["core.export"] = {},
        -- Neorg export to-file ~/out.md
        ["core.export.markdown"] = {},

        -- Metadata
        ["core.esupports.metagen"] = {
          config = { type = "auto" },
        },

        -- Neorg generate-workspace-summary work todos
        ["core.summary"] = {},

        ["core.completion"] = {
          config = {
            engine = "nvim-cmp",
          },
        },

        ["core.concealer"] = {
          config = {
            icon_preset = "diamond", -- basic, diamond, varied
            icons = {
              todo = {
                undone = { icon = " " },
              },
            },
          },
        },

        ["core.dirman"] = {
          config = {
            workspaces = {
              notes = notes_dir,
              test = "~/Syncthing/SYNC_STUFF/notes/test",
            },
            default_workspace = "notes",
          },
        },

        -- Keymaps
        ["core.keybinds"] = {
          config = {
            default_keybinds = true,
            hook = function(k)
              k.map(
                "norg",
                "n",
                "<LocalLeader>e",
                "<cmd>Neorg keybind all core.looking-glass.magnify-code-block<cr>",
                { desc = "Looking glass" }
              )
              k.map("norg", "n", "<LocalLeader>c", "<cmd>Neorg toggle-concealer<cr>", { desc = "Toggle Concealer" })
              k.map("norg", "n", "<LocalLeader>T", "<cmd>Neorg toc<cr>", { desc = "Table of Content" })
            end,
          },
        },
      },
    })
  end,
}
