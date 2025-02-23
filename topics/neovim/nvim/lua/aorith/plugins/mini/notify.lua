local M = {}

M.setup = function()
  ---@diagnostic disable-next-line: redundant-parameter
  require("mini.notify").setup({
    content = {
      -- do not append time to the notification
      format = function(notif) return notif.msg end,
    },
    window = {
      winblend = 5,
    },
  })

  vim.notify = require("mini.notify").make_notify()
  vim.api.nvim_create_user_command("Notifications", function() require("mini.notify").show_history() end, {})
  vim.keymap.set("n", "<leader>n", function() require("mini.notify").show_history() end, { desc = "Show Notifications" })
end

return M
