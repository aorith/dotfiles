return {
  'nvim-treesitter/nvim-treesitter',
  version = false,
  event = { 'BufReadPost', 'BufNewFile' },
  build = ':TSUpdate',
  cmd = { 'TSUpdateSync' },

  config = function()
    require('nvim-treesitter.configs').setup({
      highlight = {
        enable = true,
        -- TODO: bash treesitter highlights is messed up when it finds something like 'echo >&2 "blah"'
        disable = { 'sh', 'bash' },
        additional_vim_regex_highlighting = { 'sh', 'bash' },
      },

      indent = {
        enable = true,
        disable = { 'python' },
      },

      auto_install = true,
      ensure_installed = {
        'bash',
        'c',
        'jsdoc',
        'json',
        'lua',
        'luadoc',
        'luap',
        'markdown',
        'markdown_inline',
        'python',
        'query',
        'regex',
        'vim',
        'vimdoc',
        'yaml',
      },
    })
  end,
}
