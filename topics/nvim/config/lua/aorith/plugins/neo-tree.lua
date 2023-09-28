local map = vim.keymap.set
require("neo-tree").setup({
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
})

map(
  "n",
  "<leader>e",
  function() require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd(), position = "left" }) end,
  { desc = "Neo-Tree" }
)
