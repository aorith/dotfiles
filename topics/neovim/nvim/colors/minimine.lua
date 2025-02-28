vim.g.colors_name = "minimine"

local is_dark = vim.o.background == "dark"
local bg = is_dark and "#171114" or "#e9e1dd"
local fg = is_dark and "#ded3c7" or "#352d23"

local hues = require("mini.hues")
local p = hues.make_palette({
  background = bg,
  foreground = fg,
  saturation = is_dark and "medium" or "high",
  accent = "bg",
  plugins = {
    default = false,
    ["echasnovski/mini.nvim"] = true,
    ["folke/lazy.nvim"] = true,
    ["nvim-neo-tree/neo-tree.nvim"] = true,
    ["williamboman/mason.nvim"] = true,
  },
})

hues.apply_palette(p)

-- vim.notify(vim.inspect(p))

local hi = function(name, data) vim.api.nvim_set_hl(0, name, data) end
hi("CursorLineNr", { fg = p.fg_mid, bg = p.bg_mid, bold = true })
