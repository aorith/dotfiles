-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = "*",
})

-- Don't auto comment new lines
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "",
  command = "set fo-=c fo-=r fo-=o",
})

vim.cmd([[
  function! s:setLastCursorPos()
    let pos = getpos("'\"")
    let pos[2] = 0 " reset cursor to the start of the line
    call setpos('.', pos)
  endfunction

  augroup aorith_autocmds
      autocmd!

      " Last position
      autocmd BufRead * call s:setLastCursorPos()

      " For large files
      "autocmd BufWinEnter * if line2byte(line("$") + 1) > 1000000 | syntax sync clear | endif

      autocmd WinEnter,VimEnter * :silent! call matchadd('Todo', 'TODO\|FIXME', -1)
  augroup end
]])
