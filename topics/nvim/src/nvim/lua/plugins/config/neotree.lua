vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
require("neo-tree").setup({
  close_if_last_window = false,
  enable_diagnostics = true,
  enable_git_status = true,
  source_selector = {
    winbar = true,
    statusline = false,
    content_layout = "center",
  },
  default_component_configs = {
    indent = {
      padding = 0,
    },
    name = {
      trailing_slash = true,
      use_git_status_colors = false,
    },
    git_status = {
      symbols = {
        modified = "~", -- or ""
      },
    },
  },
  window = {
    position = "left",
    width = 35,
  },
  filesystem = {
    follow_current_file = true,
    hijack_netrw_behavior = "open_current",
    use_libuv_file_watcher = true,
  },
  buffers = {
    follow_current_file = true,
  },
})

require("window-picker").setup({
  use_winbar = "smart",
  autoselect_one = true,
  include_current = false,
  filter_rules = {
    -- filter using buffer options
    bo = {
      -- if the file type is one of following, the window will be ignored
      filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },

      -- if the buffer type is one of following, the window will be ignored
      buftype = { "terminal" },
    },
  },
})
