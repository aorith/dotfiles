local dark_theme = "randomhue"
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
      if theme == "randomhue" then vim.cmd.colorscheme("randomhue") end

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
              ["@text.strong.markdown_inline"] = { fg = colors.theme.syn.constant, bold = true },

              -- update kanagawa to handle new treesitter highlight captures
              ["@string.regexp"] = { link = "@string.regex" },
              ["@variable.parameter"] = { link = "@parameter" },
              ["@exception"] = { link = "@exception" },
              ["@string.special.symbol"] = { link = "@symbol" },
              ["@markup.strong"] = { link = "@text.strong" },
              ["@markup.italic"] = { link = "@text.emphasis" },
              ["@markup.heading"] = { link = "@text.title" },
              ["@markup.raw"] = { link = "@text.literal" },
              ["@markup.quote"] = { link = "@text.quote" },
              ["@markup.math"] = { link = "@text.math" },
              ["@markup.environment"] = { link = "@text.environment" },
              ["@markup.environment.name"] = { link = "@text.environment.name" },
              ["@markup.link.url"] = { link = "Special" },
              ["@markup.link.label"] = { link = "Identifier" },
              ["@comment.note"] = { link = "@text.note" },
              ["@comment.warning"] = { link = "@text.warning" },
              ["@comment.danger"] = { link = "@text.danger" },
              ["@diff.plus"] = { link = "@text.diff.add" },
              ["@diff.minus"] = { link = "@text.diff.delete" },
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
