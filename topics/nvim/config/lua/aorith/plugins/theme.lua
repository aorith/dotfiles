local dark_theme = "gruvbox"
local light_theme = "catppuccin"

local function detect_background()
  -- if vim.fn.has("macunix") == 1 then
  --   local output = vim.fn.system("defaults read -g AppleInterfaceStyle")
  --   return string.match(output, ".*Dark.*") and "dark" or "light"
  -- end
  --
  -- local output = vim.fn.system("gsettings get org.gnome.desktop.interface color-scheme")

  local output = vim.fn.system("realpath -- ~/.config/alacritty/theme.toml")
  return string.match(output, ".*dark_.*") and "dark" or "light"
end

local bg = detect_background()
vim.opt.termguicolors = true
vim.opt.background = bg

local theme = light_theme
if bg == "dark" then theme = dark_theme end

return {
  {
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      if string.find(theme, "kanagawa") then
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

  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      if string.find(theme, "onedark") then require("onedark").load() end
    end,
  },
}
