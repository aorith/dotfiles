---@diagnostic disable: missing-fields

local function detect_background()
  -- if vim.fn.has("macunix") == 1 then
  --   local output = vim.fn.system("defaults read -g AppleInterfaceStyle")
  --   return string.match(output, ".*Dark.*") and "dark" or "light"
  -- end
  --
  -- local output = vim.fn.system("gsettings get org.gnome.desktop.interface color-scheme")

  local output = vim.fn.system("realpath -- ~/.config/alacritty/theme.yml")
  return string.match(output, ".*dark_.*") and "dark" or "light"
end

local M = {}

M.setup = function()
  local bg = detect_background()

  vim.opt.termguicolors = true
  vim.opt.background = bg

  if bg == "dark" then
    -- require("kanagawa").setup({
    --   transparent = false,
    -- })
    -- vim.cmd.colorscheme("kanagawa")
    vim.cmd.colorscheme "catppuccin-macchiato"
  else
    -- vim.cmd.colorscheme("gruvbox")
    vim.cmd.colorscheme "catppuccin-frappe"
  end
end

return M
