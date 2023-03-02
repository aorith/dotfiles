return {
  {
    "nvim-treesitter/nvim-treesitter",
    version = "*",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-textobjects",
      },
    },
    keys = {
      { "<c-space>", desc = "Increment selection" },
      { "<bs>", desc = "Schrink selection", mode = "x" },
    },

    ---@type TSConfig
    opts = {
      highlight = { enable = true, disable = { "bash", "vim" }, additional_vim_regex_highlighting = {} },
      indent = { enable = true, disable = { "python", "vim" } },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = true,

      -- Automatically install missing parsers when entering buffer
      auto_install = true,

      -- List of parsers to ignore installing (for "all")
      ignore_install = {},

      ensure_installed = {
        "bash",
        "c",
        "css",
        "dockerfile",
        "gitignore",
        "go",
        "help",
        "html",
        "javascript",
        "json",
        "json5",
        "jsonc",
        "lua",
        "make",
        "markdown",
        "markdown_inline",
        "nix",
        "python",
        "query",
        "regex",
        "sql",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = "<nop>",
          node_decremental = "<bs>",
        },
      },
    },

    ---@param opts TSConfig
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
}
