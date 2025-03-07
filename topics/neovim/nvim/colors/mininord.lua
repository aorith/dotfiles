local is_dark = vim.o.background == "dark"
local p
if is_dark then
  p = {
    base00 = "#262c38",
    base01 = "#2d3444",
    base02 = "#3c4557",
    base03 = "#616E88",
    base04 = "#d8dee9",
    base05 = "#e5e9f0",
    base06 = "#eceff4",
    base07 = "#8fbcbb",
    base08 = "#bf616a",
    base09 = "#d08770",
    base0A = "#ebcb8b",
    base0B = "#a3be8c",
    base0C = "#88c0d0",
    base0D = "#81a1c1",
    base0E = "#b48ead",
    base0F = "#5e81ac",
  }
else
  p = {
    base00 = "#e5e9f0",
    base01 = "#c2d0e7",
    base02 = "#b8c5db",
    base03 = "#aebacf",
    base04 = "#60728c",
    base05 = "#2e3440",
    base06 = "#3b4252",
    base07 = "#29838d",
    base08 = "#99324b",
    base09 = "#ac4426",
    base0A = "#9a7500",
    base0B = "#4f894c",
    base0C = "#398eac",
    base0D = "#3b6ea8",
    base0E = "#97365b",
    base0F = "#5272af",
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
vim.g.colors_name = "mininord"

vim.api.nvim_set_hl(0, "MiniPickMatchMarked", { bg = p.base0E, fg = p.base00 })
vim.api.nvim_set_hl(0, "MiniPickMatchRanges", { fg = p.base0E, bold = true })
vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { bg = p.base00, fg = p.base03 })
