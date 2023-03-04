return {
  -- better vim.ui
  { "stevearc/dressing.nvim" },

  -- Better `vim.notify()`
  {
    enabled = false,
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
        "<leader>unH",
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
      filetype_exclude = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "noice" },
      show_trailing_blankline_indent = false,
      show_end_of_line = false,
      show_current_context = false,
      show_current_context_start = false,
    },
  },

  -- noicer ui
  {
    "folke/noice.nvim",
    enabled = true,
    event = "VeryLazy",
    opts = {
      cmdline = {
        -- if you want to disable the cmdline, disable messages and popupmenu too
        enabled = true,
      },
      messages = {
        enabled = true, -- enabling messages enables cmdline too
        view_search = false, -- disable search virtualtext
      },
      popupmenu = {
        enabled = true,
      },
      notify = {
        view = "mini",
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        command_palette = true,
        lsp_doc_border = true,
        bottom_search = false,
        long_message_to_split = false, -- overriden in routes
      },
      views = {
        mini = {
          --[[ for debug
          format = {
            "L:{level} ",
            "D:{date} ",
            "E:{event}",
            { "K:{kind}", before = { ".", hl_group = "NoiceFormatKind" } },
            " ",
            "T:{title} ",
            "C:{cmdline} ",
            "M:{message}",
          },
          --]]
          timeout = 3000,
          reverse = false,
          position = {
            row = 1,
            col = "100%",
          },
          win_options = {
            winblend = 35,
          },
          border = {
            style = "none",
          },
        },
      },
      routes = {
        {
          -- shell commands to output
          filter = { cmdline = "^:!" },
          view = "popup",
        },
        {
          -- lua commands to output
          filter = { cmdline = "^:lua" },
          view = "popup",
        },
        {
          -- opens long messages in a split
          filter = {
            event = "msg_show",
            min_height = 4,
          },
          view = "cmdline_output",
        },
        {
          -- ignore code actions spam
          filter = {
            event = "notify",
            find = "No code actions available",
          },
          opts = { skip = true },
        },
        --[[
        {
          -- ignore search hit BOTTOM message
          filter = {
            event = "msg_show",
            kind = "wmsg",
            find = "search hit BOTTOM",
          },
          view = "cmdline_output",
          --opts = { skip = true },
        },
        --]]
      },
    },
    -- stylua: ignore
    keys = {
      { "<S-Enter>", function() require("noice").redirect(vim.fn.getcmdline()) end, mode = "c", desc = "Redirect Cmdline" },
      { "<leader>nl", function() require("noice").cmd("last") end, desc = "Noice Last Message" },
      { "<leader>nh", function() require("noice").cmd("history") end, desc = "Noice History" },
      { "<leader>na", function() require("noice").cmd("all") end, desc = "Noice All" },
    },
  },
}
