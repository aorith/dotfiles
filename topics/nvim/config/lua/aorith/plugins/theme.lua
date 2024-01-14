local dark_theme = "kanagawa"
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
          dimInactive = false,
          transparent = false,
          background = {
            dark = "wave",
            light = "lotus",
          },
          colors = {
            theme = {
              all = {
                ui = {
                  -- remove gutter (line numbers) background
                  bg_gutter = "none",
                },
              },
            },
          },
          overrides = function(colors)
            return {
              -- https://github.com/rebelot/kanagawa.nvim/blob/master/lua/kanagawa/themes.lua
              TelescopeTitle = { fg = colors.theme.ui.special, bold = true },
              EndOfBuffer = { fg = colors.theme.ui.nontext },
              ["@text.todo.checked.markdown"] = { bg = "NONE", fg = colors.theme.vcs.added },
              ["@text.todo.unchecked.markdown"] = { bg = "NONE", fg = colors.theme.vcs.changed },
            }
          end,
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
