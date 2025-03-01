local M = {}

M.setup = function()
  require("mini.indentscope").setup({
    draw = {
      animation = require("mini.indentscope").gen_animation.none(),
    },
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = {
      "help",
      "dashboard",
      "minipick",
      "bigfile",
      "Trouble",
      "trouble",
      "lazy",
      "mason",
      "notify",
    },
    callback = function() vim.b.miniindentscope_disable = true end,
  })
end

return M
