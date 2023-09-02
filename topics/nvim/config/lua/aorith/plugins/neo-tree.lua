return {
  "nvim-neo-tree/neo-tree.nvim",

  branch = "v3.x",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },

  opts = {
    sources = {
      "filesystem",
    },

    close_if_last_window = false,
    enable_diagnostics = false,
    filesystem = {
      async_directory_scan = "always",
      bind_to_cwd = false,
      follow_current_file = {
        enabled = true,
      },
    },
    filtered_items = {
      visible = false,
      show_hidden_count = true,
      hide_dotfiles = true,
      hide_gitignored = true,
    },
    find_command = "fd",
    find_args = {
      fd = {
        "--exclude",
        ".git",
        "--exclude",
        "venv",
        "--exclude",
        ".venv",
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

    window = {
      mappings = {
        ["<space>"] = "none",
      },
    },

    renderers = {
      message = {
        { "indent", with_markers = false },
        { "name", highlight = "NeoTreeMessage" },
      },
      terminal = {
        { "indent" },
        { "icon" },
        { "name" },
        { "bufnr" },
      },
    },

    event_handlers = {
      --[[
    {
      event = "file_opened",
      handler = function(file_path)
        --auto close
        require("neo-tree.command").execute({ action = "close" })
      end,
    },
    --]]
    },
  },

  keys = {
    { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
  },
}
