require("barbecue").setup({
  create_autocmd = false, -- prevent barbecue from updating itself automatically
  attach_navic = false, -- prevent barbecue from automatically attaching nvim-navic
})

vim.api.nvim_create_autocmd({
  "WinScrolled",
  "WinResized",
  "BufWinEnter",
  "CursorHold",
  "InsertLeave",
  "BufModifiedSet",
}, {
  group = vim.api.nvim_create_augroup("barbecue.updater", {}),
  callback = function() require("barbecue.ui").update() end,
})
