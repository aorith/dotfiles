local M = {}

M.setup = function()
  ---@diagnostic disable-next-line: redundant-parameter
  require("mini.pick").setup({
    mappings = {
      choose = "<CR>",
      choose_in_split = "<C-s>",
      choose_in_tabpage = "<C-t>",
      choose_in_vsplit = "<C-v>",

      choose_marked = "<C-q>",
      mark = "<C-x>",
      mark_all = "<C-a>",
    },
  })
  vim.ui.select = MiniPick.ui_select
end

return M
