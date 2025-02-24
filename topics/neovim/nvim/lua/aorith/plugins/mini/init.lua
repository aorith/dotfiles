return {
  "echasnovski/mini.nvim",
  version = false,
  lazy = false,
  priority = 500,

  config = function()
    vim.cmd.colorscheme("randomhue")

    require("mini.icons").setup()
    require("mini.icons").mock_nvim_web_devicons()
    require("aorith.plugins.mini.notify").setup()

    require("mini.basics").setup({
      -- Options. Set to `false` to disable.
      options = {
        -- Basic options ('number', 'ignorecase', and many more)
        basic = false,

        -- Extra UI features ('winblend', 'cmdheight=0', ...)
        extra_ui = false,

        -- Presets for window borders ('single', 'double', ...)
        win_borders = "bold",
      },

      -- Mappings. Set to `false` to disable.
      mappings = {
        -- Basic mappings (better 'jk', save with Ctrl+S, ...)
        basic = true,

        -- Prefix for mappings that toggle common options ('wrap', 'spell', ...).
        -- Supply empty string to not create these mappings.
        option_toggle_prefix = [[<leader>t]],

        -- Window navigation with <C-hjkl>, resize with <C-arrow>
        windows = false,

        -- Move cursor in Insert, Command, and Terminal mode with <M-hjkl>
        move_with_alt = false,
      },

      -- Autocommands. Set to `false` to disable
      autocommands = {
        -- Basic autocommands (highlight on yank, start Insert in terminal, ...)
        basic = false,

        -- Set 'relativenumber' only in linewise and blockwise Visual mode
        relnum_in_visual_mode = false,
      },

      -- Whether to disable showing non-error feedback
      silent = false,
    })

    require("mini.extra").setup()
    require("mini.diff").setup({ view = { style = "sign" } })
    require("mini.git").setup({ command = { split = "vertical" } })
    require("mini.ai").setup() -- Enables 'ciq' (change inside quotes) or 'cib' (change inside brackets), etc.
    require("mini.misc").setup()
    require("mini.bufremove").setup()
    local starter = require("mini.starter")
    starter.setup({
      evaluate_single = true,
      items = {
        starter.sections.recent_files(4, true),
        starter.sections.recent_files(5, false),
        starter.sections.builtin_actions(),
      },
      content_hooks = {
        starter.gen_hook.adding_bullet(),
        starter.gen_hook.indexing("all", { "Builtin actions" }),
        starter.gen_hook.aligning("center", "center"),
      },
    })

    require("mini.cursorword").setup()
    require("mini.indentscope").setup({
      draw = {
        animation = require("mini.indentscope").gen_animation.none(),
      },
    })
    vim.api.nvim_create_autocmd("FileType", {
      pattern = {
        "help",
        "dashboard",
        "minipick",
        "bigfile",
        "Trouble",
        "trouble",
        "lazy",
        "mason",
        "notify",
      },
      callback = function() vim.b.miniindentscope_disable = true end,
    })

    -- sa => surround around
    -- sd => surround delete
    -- sr => surround replace
    -- Example: Visual select a word -> sa"  (surround around quotes, 'saq' with mini.ai)
    require("mini.surround").setup()
    require("mini.visits").setup()

    require("mini.tabline").setup()
    require("aorith.plugins.mini.statusline").setup()

    require("aorith.plugins.mini.pick").setup()
    require("aorith.plugins.mini.files").setup()
    require("aorith.plugins.mini.hipatterns").setup()
    require("aorith.plugins.mini.clue").setup()
    require("aorith.plugins.mini.completion").setup()

    vim.keymap.set("n", "<leader>q", function() require("mini.bufremove").delete() end, { desc = "Delete current buffer" })
    vim.keymap.set("n", "<leader>z", function() MiniMisc.zoom() end, { desc = "Zoom window" })
    vim.keymap.set("n", "<leader>go", function() require("mini.diff").toggle_overlay(0) end, { desc = "Toggle diff overlay" })
  end,
}
