vim.opt_local.textwidth = 72
vim.wo.colorcolumn = "+0"

vim.opt_local.foldmethod = "expr"
vim.opt_local.foldexpr = "v:lua.MiniGit.diff_foldexpr()"
