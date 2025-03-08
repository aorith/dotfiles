local is_dark = vim.o.background == "dark"
local p
if is_dark then
  p = {
    base00 = "#002b36",
    base01 = "#073642",
    base02 = "#586e75",
    base03 = "#657b83",
    base04 = "#839496",
    base05 = "#93a1a1",
    base06 = "#eee8d5",
    base07 = "#fdf6e3",
    base08 = "#dc322f",
    base09 = "#cb4b16",
    base0A = "#b58900",
    base0B = "#859900",
    base0C = "#2aa198",
    base0D = "#268bd2",
    base0E = "#6c71c4",
    base0F = "#d33682",
  }
else
  p = {
    base00 = "#fdf6e3",
    base01 = "#eee8d5",
    base02 = "#93a1a1",
    base03 = "#839496",
    base04 = "#657b83",
    base05 = "#586e75",
    base06 = "#073642",
    base07 = "#002b36",
    base08 = "#dc322f",
    base09 = "#cb4b16",
    base0A = "#b58900",
    base0B = "#859900",
    base0C = "#2aa198",
    base0D = "#268bd2",
    base0E = "#6c71c4",
    base0F = "#d33682",
  }
end

require("mini.base16").setup({
  palette = p,
  use_cterm = true,
  plugins = {
    default = false,
    ["echasnovski/mini.nvim"] = true,
    ["nvim-neo-tree/neo-tree.nvim"] = true,
    ["williamboman/mason.nvim"] = true,
  },
})
vim.g.colors_name = "minisolarized"

vim.api.nvim_set_hl(0, "MiniPickMatchCurrent", { bg = p.base00 })
vim.api.nvim_set_hl(0, "MiniPickMatchRanges", { fg = p.base0F, bold = true })
vim.api.nvim_set_hl(0, "MiniPickMatchMarked", { bg = p.base0E, fg = p.base00 })

vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { bg = p.base00, fg = p.base03 })
vim.api.nvim_set_hl(0, "MiniStatuslineDevinfo", { bg = p.base04, fg = p.base00 })
