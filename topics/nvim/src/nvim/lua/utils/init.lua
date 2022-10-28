_G.dump = function(...)
  vim.pretty_print(...)
end

_G.dumpp = function(...)
  local msg = vim.inspect(...)
  vim.notify(msg, vim.log.levels.INFO, {
    title = "Debug",
    on_open = function(win)
      vim.api.nvim_win_set_option(win, "conceallevel", 3)
      local buf = vim.api.nvim_win_get_buf(win)
      vim.api.nvim_buf_set_option(buf, "filetype", "lua")
      vim.api.nvim_win_set_option(win, "spell", false)
    end,
  })
end
