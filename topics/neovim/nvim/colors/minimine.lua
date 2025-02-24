local is_dark = vim.o.background == "dark"

require("mini.hues").setup({
  background = is_dark and "#27211e" or "#e9e1dd",
  foreground = is_dark and "#ded3c7" or "#352d23",
  saturation = is_dark and "medium" or "high",
  -- accent = "yellow",
})

vim.g.colors_name = "minimine"
