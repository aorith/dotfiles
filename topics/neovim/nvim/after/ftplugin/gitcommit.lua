vim.bo.textwidth = 72

vim.wo.colorcolumn = "+0"
vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.MiniGit.diff_foldexpr()"
