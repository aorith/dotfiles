return {
  "echasnovski/mini.nvim",
  version = false,
  lazy = false,

  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  config = function()
    require("mini.bufremove").setup()
    require("mini.tabline").setup()
    require("mini.trailspace").setup()
    require("mini.misc").setup()
    require("mini.comment").setup()

    require("aorith.plugins.mini.files")
    require("aorith.plugins.mini.statusline")
    require("aorith.plugins.mini.hipatterns")
    require("aorith.plugins.mini.clue")
    require("aorith.plugins.mini.completion").setup()
  end,

  keys = {
    -- Bufremove
    {
      "<leader>q",
      function()
        MiniBufremove.delete()
      end,
      mode = "n",
      desc = "Delete current buffer",
    },
    {
      "<leader>Q",
      function()
        MiniBufremove.delete(nil, true)
      end,
      mode = "n",
      desc = "Force delete current buffer",
    },

    -- Files
    {
      "-",
      function()
        MiniFiles.open()
      end,
      mode = "n",
      desc = "MiniFiles",
    },

    -- Mini misc zoom
    {
      "<leader>z",
      function()
        MiniMisc.zoom()
      end,
      mode = "n",
      desc = "Zoom",
    },

    -- end keys
  },
}
