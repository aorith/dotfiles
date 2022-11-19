-- Bufferline
require("bufferline").setup({
  options = {
    mode = "buffers",
    separator_style = "slant",
    numbers = "ordinal",
    diagnostics = true,
    offsets = {
      { filetype = "neo-tree", text = "", separator = false },
    },
  },
})

local char_under_cursor = {
  function()
    return "0x%B"
  end,
}

require("lualine").setup({
  options = {
    globalstatus = true,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_y = { "progress", "location" },
    lualine_z = { char_under_cursor },
  },
  extensions = { "neo-tree", "quickfix" },
})
