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
        disable = { "sh", "bash", "dockerfile" },
        additional_vim_regex_highlighting = false,
      },

      indent = {
        enable = true,
      },

      auto_install = true,
      ignore_install = {},
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
    })

    vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
  end,
}
