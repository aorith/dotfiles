return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = function()
      require("nvim-treesitter.install").update({ with_sync = true })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- A list of parser names, or "all"
        ensure_installed = {
          "c",
          "lua",
          "python",
          "bash",
          "go",
          "css",
          "html",
          "json",
          "json5",
          "make",
          "nix",
          "sql",
          "toml",
          "vim",
          "yaml",
          "dockerfile",
          "gitignore",
        },

        highlight = {
          enable = true,
          additional_vim_regex_highlighting = {},
        },

        indent = { enable = true, disable = { "python" } },

        -- Install parsers synchronously (only applied to `ensure_installed`)
        sync_install = true,

        -- Automatically install missing parsers when entering buffer
        auto_install = true,

        -- List of parsers to ignore installing (for "all")
        ignore_install = {},
      })
    end,
  },
}
