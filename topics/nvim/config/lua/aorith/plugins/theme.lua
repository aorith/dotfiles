local dark_theme = "catppuccin"
local light_theme = "catppuccin-frappe"

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

local bg = detect_background()
vim.opt.termguicolors = true
vim.opt.background = bg

if bg == "dark" then
  theme = dark_theme
else
  theme = light_theme
end

return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      if theme == "kanagawa" then
        require("kanagawa").setup({
          transparent = false,
        })
        vim.cmd.colorscheme(theme)
      end
    end,
  },

  {

    "catppuccin/nvim",
    lazy = false,
    priority = 1000,
    config = function()
      if string.find(theme, "catppuccin") then vim.cmd.colorscheme(theme) end
    end,
  },

  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      if string.find(theme, "gruvbox") then vim.cmd.colorscheme(theme) end
    end,
  },
}
