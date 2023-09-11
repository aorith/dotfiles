return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  cmd = "Neotree",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },

  deactivate = function()
    vim.cmd([[Neotree close]])
  end,

  opts = {
    enable_diagnostics = false,
    sources = { "filesystem", "document_symbols" },
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = { enabled = true },
      use_libuv_file_watcher = true,
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
  },

  keys = {
    {
      "<leader>e",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd(), position = "left" })
      end,
      desc = "Explorer NeoTree (cwd)",
    },
  },
}
