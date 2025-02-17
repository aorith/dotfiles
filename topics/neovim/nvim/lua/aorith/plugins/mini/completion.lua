local M = {}

M.setup = function()
  require("mini.completion").setup({
    set_vim_settings = true,

    window = {
      info = { border = "single" },
      signature = { border = "single" },
    },

    lsp_completion = {
      auto_setup = false, -- Done manually on 'lsp.lua'
    },
  })

  if vim.fn.has("nvim-0.11") == 1 then
    vim.opt.completeopt:append("fuzzy") -- Use fuzzy matching for built-in completion
  end

  -- More consistent behavior of `<CR>`
  local keys = {
    ["cr"] = vim.keycode("<CR>"),
    ["ctrl-y"] = vim.keycode("<C-y>"),
    ["ctrl-y_cr"] = vim.keycode("<C-y><CR>"),
  }

  _G.cr_action = function()
    if vim.fn.pumvisible() ~= 0 then
      -- If popup is visible, confirm selected item or add new line otherwise
      local item_selected = vim.fn.complete_info()["selected"] ~= -1
      return item_selected and keys["ctrl-y"] or keys["ctrl-y_cr"]
    else
      -- If popup is not visible, use plain `<CR>`. You might want to customize
      -- according to other plugins. For example, to use 'mini.pairs', replace
      -- next line with `return require('mini.pairs').cr()`
      return keys["cr"]
    end
  end

  map("i", "<CR>", "v:lua._G.cr_action()", { expr = true })

  map("i", "<Tab>", [[pumvisible() ? "\<C-n>" : "\<Tab>"]], { expr = true })
  map("i", "<S-Tab>", [[pumvisible() ? "\<C-p>" : "\<S-Tab>"]], { expr = true })

  require("mini.icons").tweak_lsp_kind()
end

return M
