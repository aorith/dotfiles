-- Change the themes with <F1>
-- Theme definitions are stored in ~/.theme/dark_vim_theme
-- and in ~/.theme/light_vim_theme

vim.cmd 'let g:tempus_enforce_background_color=1'

local function file_exists(fname)
	local stat = vim.loop.fs_stat(fname)
	return (stat and stat.type) or false
end

-- Get current values for light and dark theme
-- light
local themepath = os.getenv("HOME") .. "/.theme/light_vim_theme"
if file_exists(themepath) then
  local themefile = io.open(themepath, "r")
  my_light_theme = themefile:read()
else
  my_light_theme = "tempus_day"
  local themefile = io.open(themepath, "w")
  themefile:write(my_light_theme)
  themefile:close()
end
-- dark
local themepath = os.getenv("HOME") .. "/.theme/dark_vim_theme"
if file_exists(themepath) then
  local themefile = io.open(themepath, "r")
  my_dark_theme = themefile:read()
else
  my_dark_theme = "tempus_winter"
  local themefile = io.open(themepath, "w")
  themefile:write(my_dark_theme)
  themefile:close()
end

-- Function and mapping to toggle the theme
function ToggleTotusTheme()
  local filepath = os.getenv("HOME") .. "/.local/share/nvim/darkmode"
  local stat = vim.loop.fs_stat(filepath)
  if (stat and stat.type) then
    vim.cmd ('colorscheme ' .. my_light_theme)
    os.remove(filepath)
  else
    vim.cmd ('colorscheme ' .. my_dark_theme)
    os.execute('touch ~/.local/share/nvim/darkmode')
  end
end

vim.api.nvim_set_keymap('', '<F1>', '<Esc><Esc>:lua ToggleTotusTheme()<CR>',
  { noremap = true, silent = true })

-- Initial configuration
if file_exists(os.getenv("HOME") .. "/.local/share/nvim/darkmode") then
  vim.cmd ('colorscheme ' .. my_dark_theme)
else
  vim.cmd ('colorscheme ' .. my_light_theme)
end
