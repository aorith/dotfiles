return {
  'echasnovski/mini.nvim',
  version = '*',

  config = function()
    require('mini.completion').setup({
      -- Configuration for action windows:
      -- - `height` and `width` are maximum dimensions.
      -- - `border` defines border (as in `nvim_open_win()`).
      window = {
        info = { height = 25, width = 80, border = 'rounded' },
        signature = { height = 25, width = 80, border = 'rounded' },
      },
    })

    vim.keymap.set('i', '<Tab>', [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
    vim.keymap.set('i', '<S-Tab>', [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })
  end,
}
