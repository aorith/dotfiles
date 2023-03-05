return {
  { "mbbill/undotree", keys = {
    { "<leader>U", "<cmd>UndotreeToggle<cr>", desc = "Undotree" },
  } },

  { "varnishcache-friends/vim-varnish" },

  {
    "ojroques/nvim-osc52",
    config = function()
      vim.keymap.set("n", "<leader>c", require("osc52").copy_operator, { expr = true, desc = "Osc52 copy operator" })
      vim.keymap.set("x", "<leader>y", require("osc52").copy_visual, { desc = "Osc52 copy visual selection" })
      -- this remap doesn't work inside of lazy keys table
      vim.keymap.set("n", "<leader>y", "<leader>c_", { remap = true, desc = "Osc52 copy current line" })
    end,
  },

  { "tpope/vim-fugitive" },

  {
    "numToStr/FTerm.nvim",
    lazy = true,
    init = function()
      -- Custom terminal
      local fterm = require("FTerm")
      local lazygit = fterm:new({
        cmd = "lazygit",
        auto_close = true,
        dimensions = { height = 1, width = 1 },
      })

      vim.api.nvim_create_user_command("LazyGit", function()
        lazygit:toggle()
      end, { bang = true })
    end,
    config = function()
      require("FTerm").setup({
        dimensions = {
          height = 1,
          width = 1,
        },
      })
    end,
    keys = {
      {
        "<leader>t",
        function()
          require("FTerm").toggle()
        end,
        desc = "Toggle Term",
      },
      {
        "<leader>gl",
        function()
          require("FTerm")
          vim.cmd.LazyGit()
        end,
        mode = "n",
        desc = "LazyGit",
      },
    },
  },
}
