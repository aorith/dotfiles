return {
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
  },

  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local tc = require("telescope")
      local tcb = require("telescope.builtin")
      local tct = require("telescope.themes")

      tc.setup({
        defaults = {
          file_ignore_patterns = { "venv", "__pycache__", ".git" },
          path_display = { truncate = 5 },
          dynamic_preview_title = true,
          scroll_strategy = "limit",
          layout_strategy = "bottom_pane",
          layout_config = {
            vertical = { width = 0.98 },
            horizontal = { width = 0.98 },
            bottom_pane = {
              prompt_position = "bottom",
            },
          },
          mappings = {
            i = {
              -- disable if you want to use normal mode in telescope
              ["<esc>"] = function(...) require("telescope.actions").close(...) end,
              ["<c-d>"] = function(...) require("telescope.actions").delete_buffer(...) end,
            },
            n = {
              ["q"] = function(...) return require("telescope.actions").close(...) end,
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
