return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },

  config = function()
    map("n", "<leader>e", function() require("neo-tree.command").execute({ toggle = true, dir = vim.uv.cwd(), position = "left" }) end, { desc = "Neo-Tree" })

    require("neo-tree").setup({
      sources = { "filesystem" },

      enable_diagnostics = false,
      enable_git_status = false,

      filesystem = {
        bind_to_cwd = false,
        follow_current_file = { enabled = true },
      },

      window = {
        mappings = {
          ["<space>"] = "none",
        },
      },

      default_component_configs = {
        name = {
          trailing_slash = true,
          use_git_status_colors = false,
        },
        indent = {
          with_expanders = true,
        },
      },
    })
  end,
}
