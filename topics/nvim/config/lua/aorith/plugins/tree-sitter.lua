return {
  "nvim-treesitter/nvim-treesitter",
  version = false, -- use last version from git
  build = ":TSUpdate",
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

          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<LocalLeader>s",
          node_incremental = "<LocalLeader>s",
          node_decremental = "<LocalLeader>d",
        },
      },
    })

    -- Folds
    vim.opt.foldmethod = "expr"
    vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
  end,
}
