return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,
          side = "right",
          mappings = {
            list = {
              { key = "cd", action = "cd" },
            },
          },
        },
        renderer = {
          group_empty = true,
          add_trailing = true,
          icons = {
            git_placement = "after",
            modified_placement = "after",
          },
        },
        modified = {
          enable = true,
        },
        filters = {
          dotfiles = true,
        },
      })
    end,
  },
}
