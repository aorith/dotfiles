map("n", "-", function() require("oil").open() end, { desc = "Open parent directory" })

return {
  "stevearc/oil.nvim",
  version = "*",
  lazy = true,
  cmd = "Oil",
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
  end,
}
