require("neo-tree").setup({
  sources = { "filesystem" },

  enable_diagnostics = false,
  enable_git_status = false,

  filesystem = {
    hijack_netrw_behavior = "disabled",
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
