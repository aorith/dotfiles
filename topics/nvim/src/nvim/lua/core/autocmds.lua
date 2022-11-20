-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- Don't auto commenting new lines
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "",
  command = "set fo-=c fo-=r fo-=o",
})

vim.cmd([[
  augroup aorith_autocmds
      autocmd!

      " Last position without centered cursor
      autocmd BufRead * autocmd FileType <buffer> ++once
      \ if &ft !~# 'commit\|rebase' && line("'\"") > 1 && line("'\"") <= line("$") | exe 'normal! g`"'0 | endif

      " For large files
      "autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax sync clear | endif

      autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO\|FIXME', -1)
  augroup end
]])
