return {
  "stevearc/oil.nvim",
  version = "*",
  lazy = false,
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("oil").setup({
      columns = {
        "icon",
        "permissions",
        "size",
        "mtime",
      },
      keymaps = {
        ["q"] = "actions.close",
      },
    })
    map("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end,
}
