
-- Function and mapping to toggle the theme
function ToggleTotusTheme()
  local filepath = os.getenv("HOME") .. "/.local/share/nvim/darkmode"
  local stat = vim.loop.fs_stat(filepath)
  if (stat and stat.type) then
    vim.cmd 'colorscheme tempus_day'
    os.remove(filepath)
  else
    vim.cmd 'colorscheme tempus_dusk'
    os.execute('touch ~/.local/share/nvim/darkmode')
  end
end

vim.api.nvim_set_keymap('', '<F1>', '<Esc><Esc>:lua ToggleTotusTheme()<CR>',
  { noremap = true, silent = true })

vim.cmd 'let g:tempus_enforce_background_color=1'

-- Initial configuration
local function file_exists(fname)
	local stat = vim.loop.fs_stat(fname)
	return (stat and stat.type) or false
end

if file_exists(os.getenv("HOME") .. "/.local/share/nvim/darkmode") then
  --vim.cmd 'set background="dark"'
  vim.cmd 'colorscheme tempus_dusk'
else
  --vim.cmd 'set background="light"'
  vim.cmd 'colorscheme tempus_day'
end
