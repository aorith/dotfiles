local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("aorith.plugins", {
  change_detection = { notify = false },
  checker = {
    enabled = true,
    concurrency = 20,
    notify = false,
    frequency = 3600,
  },
  defaults = { lazy = true },
})
