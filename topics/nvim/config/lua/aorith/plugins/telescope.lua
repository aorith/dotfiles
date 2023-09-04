return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },

  cmd = { "Telescope" },

  config = function()
    require("telescope").setup({
      extensions = {
        fzf = {
          fuzzy = true, -- false will only do exact matching
          override_generic_sorter = true, -- override the generic sorter
          override_file_sorter = true, -- override the file sorter
          case_mode = "smart_case", -- or "ignore_case" or "respect_case"
          -- the default case_mode is "smart_case"
        },
      },
      defaults = {
        file_ignore_patterns = { ".venv", "venv", "__pycache__", ".git" },
        mappings = {
          i = {
            -- disable if you want to use normal mode in telescope
            ["<esc>"] = function(...)
              require("telescope.actions").close(...)
            end,

            ["<c-d>"] = function(...)
              require("telescope.actions").delete_buffer(...)
            end,
          },
          n = {
            ["q"] = function(...)
              return require("telescope.actions").close(...)
            end,
          },
        },
      },
    })

    require("telescope").load_extension("fzf")
  end,

  keys = {
    { "<leader><space>", "<cmd>Telescope buffers<cr>", mode = "n", desc = "Switch Buffer" },
    { "<leader>:", "<cmd>Telescope command_history<cr>", mode = "n", desc = "Command history" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", mode = "n", desc = "Find Files" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", mode = "n", desc = "Recent Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", mode = "n", desc = "Live Grep" },
    {
      "<leader>fG",
      function()
        require("telescope.builtin").live_grep({ grep_open_files = true })
      end,
      mode = "n",
      desc = "Grep Open Files",
    },
    { "<leader>fw", "<cmd>Telescope grep_string<cr>", mode = "n", desc = "Grep word" },

    -- search
    {
      "<leader>/",
      function()
        require("telescope.builtin").current_buffer_fuzzy_find({ skip_empty_lines = true })
      end,
      mode = "n",
      desc = "Search current buffer",
    },
    { "<leader>sd", "<cmd>Telescope diagnostics<cr>", mode = "n", desc = "Diagnostics" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", mode = "n", desc = "Vim Help" },
    { "<leader>sG", "<cmd>Telescope git_files<cr>", mode = "n", desc = "Git files" },

    -- git
    { "<leader>gc", "<cmd>Telescope git_commits<cr>", mode = "n", desc = "commits" },
    { "<leader>gs", "<cmd>Telescope git_status<cr>", mode = "n", desc = "status" },

    -- extras
    { "<leader>seC", "<cmd>Telescope commands<cr>", mode = "n", desc = "Commands" },
    { "<leader>seH", "<cmd>Telescope highlights<cr>", mode = "n", desc = "Search Highlight Groups" },
    { "<leader>sek", "<cmd>Telescope keymaps<cr>", mode = "n", desc = "Key Maps" },
    { "<leader>sea", "<cmd>Telescope autocommands<cr>", mode = "n", desc = "Auto Commands" },
    { "<leader>seo", "<cmd>Telescope vim_options<cr>", mode = "n", desc = "Options" },

    {
      "<leader>uc",
      function()
        require("telescope.builtin").colorscheme({ enable_preview = true })
      end,
      mode = "n",
      desc = "Colorschemes",
    },
  },
}
