return {
  "nvim-treesitter/nvim-treesitter",
  version = false, -- use last version from git
  build = ":TSUpdate",
  lazy = false,
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },

  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
      highlight = {
        enable = true,
        disable = { "sh", "bash", "dockerfile" },
        additional_vim_regex_highlighting = { "sh", "bash", "dockerfile", "org" },
      },

      indent = {
        enable = true,
      },

      auto_install = true,
      ignore_install = {},
      ensure_installed = {
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        "python",
        "norg",
        "norg_meta",
      },

      textobjects = {
        select = {
          enable = true,

          -- If outside of an object, jump to the next one
          lookahead = true,

          -- For example, 'vaf' would enter visual mode and select the defined @function.outer
          keymaps = {
            ["af"] = { query = "@function.outer", desc = "Function outer" },
            ["if"] = { query = "@function.inner", desc = "Function inner" },
            ["ac"] = { query = "@class.outer", desc = "Class outer" },
            ["ic"] = { query = "@class.inner", desc = "Class inner" },
          },
        },

        move = {
          enable = true,
          set_jumps = false,
          goto_next_start = {
            ["]f"] = { query = "@function.outer", desc = "Next Function outer" },
            ["]c"] = { query = "@class.outer", desc = "Next Class outer" },
          },
          goto_next_end = {
            ["]F"] = { query = "@function.outer", desc = "Next Function outer end" },
            ["]C"] = { query = "@class.outer", desc = "Next Class outer end" },
          },
          goto_previous_start = {
            ["[f"] = { query = "@function.outer", desc = "Prev Function outer" },
            ["[c"] = { query = "@class.outer", desc = "Prev Class outer" },
          },
          goto_previous_end = {
            ["[F"] = { query = "@function.outer", desc = "Prev Function outer end" },
            ["[C"] = { query = "@class.outer", desc = "Prev Class outer end" },
          },
        },
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<LocalLeader>+",
          node_incremental = "<LocalLeader>+",
          node_decremental = "<LocalLeader>-",
        },
      },
    })

    -- Folds
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  end,
}
