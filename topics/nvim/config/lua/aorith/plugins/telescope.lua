return {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    lazy = false,
    build = "make",
  },

  {
    "nvim-telescope/telescope.nvim",
    version = "*",
    dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzf-native.nvim", "folke/trouble.nvim" },
    lazy = false,

    config = function()
      local tc = require("telescope")
      local tcb = require("telescope.builtin")
      local tct = require("telescope.themes")

      tc.setup({
        defaults = {
          file_ignore_patterns = { ".venv", "venv", "__pycache__", ".git" },
          path_display = { smart = true },
          dynamic_preview_title = true,
          layout_strategy = "horizontal",
          layout_config = {
            vertical = { width = 0.98, preview_width = 0.5 },
            horizontal = { width = 0.98, preview_width = 0.5 },
          },
          mappings = {
            i = {
              -- C-q opens all in quickfix list
              ["<c-t>"] = function(...) require("trouble.providers.telescope").open_with_trouble(...) end,

              -- disable if you want to use normal mode in telescope
              ["<esc>"] = function(...) require("telescope.actions").close(...) end,

              ["<c-d>"] = function(...) require("telescope.actions").delete_buffer(...) end,
              ["<C-Up>"] = function(...) require("telescope.actions").preview_scrolling_up(...) end,
              ["<C-Down>"] = function(...) require("telescope.actions").preview_scrolling_down(...) end,
            },
            n = {
              ["q"] = function(...) return require("telescope.actions").close(...) end,
              ["<c-t>"] = function(...) require("trouble.providers.telescope").open_with_trouble(...) end,
              ["<C-Up>"] = function(...) require("telescope.actions").preview_scrolling_up(...) end,
              ["<C-Down>"] = function(...) require("telescope.actions").preview_scrolling_down(...) end,
            },
          },
        },

        extensions = {
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
      })

      tc.load_extension("fzf")

      --- keymaps
      map(
        "n",
        "<leader><space>",
        function() tcb.buffers(tct.get_dropdown({ layout_config = { width = 0.8 } })) end,
        { desc = "Switch Buffer" }
      )

      -- find
      map("n", "<leader>ff", function() tcb.find_files() end, { desc = "Find Files" })
      map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent" })
      map("n", "<leader>fg", function() tcb.live_grep({}) end, { desc = "Grep ALL" })
      map("n", "<leader>fG", function() tcb.live_grep({ grep_open_files = true }) end, { desc = "Grep open files" })
      map("n", "<leader>fm", "<cmd>Telescope marks<cr>", { desc = "Marks" })
      -- git
      map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "commits" })
      map("n", "<leader>gs", "<cmd>Telescope git_status<CR>", { desc = "status" })
      -- search
      map("n", "<leader>/", function() tcb.current_buffer_fuzzy_find({ skip_empty_lines = true }) end, {
        desc = "Search current buffer",
      })

      map("n", "<leader>sd", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })
      map("n", "<leader>sh", "<cmd>Telescope help_tags<cr>", { desc = "Vim Help" })
      map("n", "<leader>sG", "<cmd>Telescope git_files<CR>", { desc = "Git files" })

      map("n", "<leader>uc", function() tcb.colorscheme({ enable_preview = true }) end, {
        desc = "Colorscheme with preview",
      })
    end,
  },
}
