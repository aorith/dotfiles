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

  auto_install = false,
  ignore_install = {},
  ensure_installed = {},

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
})

vim.cmd("set foldexpr=nvim_treesitter#foldexpr()")
