return {
  -- better vim.ui
  { "stevearc/dressing.nvim" },

  -- Better `vim.notify()`
  {
    enabled = true,
    "rcarriga/nvim-notify",
    opts = {
      fps = 60,
      render = "compact",
      stages = "fade",
      top_down = true,
    },
    keys = {
      {
        "<leader>und",
        function()
          require("notify").dismiss({ silent = true, pending = true })
        end,
        desc = "Delete all Notifications",
      },
      {
        "<leader>unh",
        function()
          require("telescope").extensions.notify.notify()
        end,
        desc = "Notifications history in telescope",
      },
    },
    init = function()
      require("notify").setup({
        on_open = function(win)
          vim.api.nvim_win_set_config(win, { focusable = false })
        end,
      })
      vim.notify = require("notify")
    end,
  },

  -- indent guides for Neovim
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      --char = "▏",
      char = "│",
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy" },
      show_trailing_blankline_indent = false,
      show_current_context = false,
    },
  },

  -- active indent guide and indent text objects
  {
    enabled = false,
    "echasnovski/mini.indentscope",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      --symbol = "▏",
      symbol = "│",
      options = { try_as_border = true },
    },
    config = function(_, opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason" },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
      require("mini.indentscope").setup(opts)
    end,
  },

  -- noicer ui
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = {
        view = "cmdline",
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      messages = {
        view = "mini",
        view_search = false, -- disable search virtualtext
      },
      presets = {
        bottom_search = true,
        command_palette = false,
        inc_rename = false,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
      --[[- buggy
      routes = {
        { -- opens long messages in a split
          filter = {
            min_height = 6,
          },
          view = "split",
        },
      },
      --]]
    },
    -- stylua: ignore
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>unl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>unH", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>una", function() require("noice").cmd("all") end, desc = "Noice All" },
    },
  },
}
