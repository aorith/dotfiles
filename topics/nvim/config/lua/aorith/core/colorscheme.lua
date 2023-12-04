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

local bg = detect_background()

vim.opt.termguicolors = true
vim.opt.background = bg

--vim.cmd.colorscheme("randomhue")
--vim.cmd.colorscheme("minicyan")
--vim.cmd.colorscheme("minischeme")

if bg == "dark" then
  require("kanagawa").setup({
    transparent = false,
  })
  vim.cmd.colorscheme("kanagawa")

  -- require("dracula").setup({
  --   show_end_of_buffer = true,
  --   transparent_bg = true,
  -- })
  -- vim.cmd.colorscheme("dracula-soft")

  -- require("catppuccin").setup({
  --   transparent_background = true,
  --   show_end_of_buffer = true,
  --   integrations = {
  --     nvimtree = false,
  --     mini = true,
  --   },
  -- })
  -- vim.cmd.colorscheme("catppuccin-mocha")

  -- vim.cmd.colorscheme("gruvbox")
else
  -- require("catppuccin").setup({
  --   transparent_background = true,
  --   show_end_of_buffer = true,
  --   integrations = {
  --     nvimtree = false,
  --     mini = true,
  --   },
  -- })
  -- vim.cmd.colorscheme("catppuccin-latte")

  -- require("github-theme").setup({
  --   options = {
  --     transparent = true,
  --   },
  -- })
  -- vim.cmd.colorscheme("github_light_high_contrast")

  vim.cmd.colorscheme("gruvbox")
end
