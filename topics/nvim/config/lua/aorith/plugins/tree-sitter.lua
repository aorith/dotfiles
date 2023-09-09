return {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  version = false,
  event = { "BufReadPost", "BufNewFile" },
  build = ":TSUpdate",
  cmd = { "TSUpdateSync" },

  config = function()
    ---@diagnostic disable-next-line: missing-fields
    require("nvim-treesitter.configs").setup({
      highlight = {
        enable = true,
        use_languagetree = true,
        -- TODO: bash treesitter highlights is messed up when it finds something like 'echo >&2 "blah"'
        disable = { "sh", "bash", "dockerfile" },
      },

      indent = {
        enable = true,
        disable = { "python" },
      },

      auto_install = true,
      ensure_installed = {
        "bash",
        "c",
        "jsdoc",
        "json",
        "lua",
        "luadoc",
        "luap",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "vim",
        "vimdoc",
        "yaml",
      },

      ignore_install = {},
    })

    vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
  end,
}
