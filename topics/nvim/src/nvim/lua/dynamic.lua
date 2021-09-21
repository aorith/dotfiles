-- Change the themes with <F1>
-- Theme definitions are stored in ~/.local/share/vim/light_theme
-- and in ~/.local/share/vim/dark_theme

vim.cmd 'let g:tempus_enforce_background_color=1'

-- Defaults
my_light_theme = "tempus_day"
my_dark_theme = "tempus_winter"

local function file_exists(fname)
	local stat = vim.loop.fs_stat(fname)
	return (stat and stat.type) or false
end

-- Get current values for light and dark theme
-- light
local themepath = os.getenv("HOME") .. "/.local/share/vim/light_theme"
if file_exists(themepath) then
  local themefile = io.open(themepath, "r")
  my_light_theme = themefile:read()
else
  local themefile = io.open(themepath, "w")
  themefile:write(my_light_theme)
  themefile:close()
end
-- dark
local themepath = os.getenv("HOME") .. "/.local/share/vim/dark_theme"
if file_exists(themepath) then
  local themefile = io.open(themepath, "r")
  my_dark_theme = themefile:read()
else
  local themefile = io.open(themepath, "w")
  themefile:write(my_dark_theme)
  themefile:close()
end

-- Function and mapping to toggle the theme
function ToggleMyTheme()
  if (os.getenv("USER")) == "root" then
    vim.cmd ('echo "Root is not allowed."')
    return
  end
  local filepath = os.getenv("HOME") .. "/.local/share/vim/darkmode"
  local stat = vim.loop.fs_stat(filepath)
  if (stat and stat.type) then
    vim.cmd ('set bg=light')
    vim.cmd ('colorscheme ' .. my_light_theme)
    os.remove(filepath)
  else
    vim.cmd ('set bg=dark')
    vim.cmd ('colorscheme ' .. my_dark_theme)
    os.execute('touch ~/.local/share/vim/darkmode')
  end
end

vim.api.nvim_set_keymap('', '<F1>', '<Esc><Esc>:lua ToggleMyTheme()<CR>',
  { noremap = true, silent = true })

-- Initial configuration
if file_exists(os.getenv("HOME") .. "/.local/share/vim/darkmode") then
  vim.cmd ('set bg=dark')
  vim.cmd ('colorscheme ' .. my_dark_theme)
else
  vim.cmd ('set bg=light')
  vim.cmd ('colorscheme ' .. my_light_theme)
end
