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

local get_active_lsp_clients = {
  function()
    local servers = nil
    for _, c in pairs(vim.lsp.buf_get_clients()) do
      if c.name ~= "null-ls" then
        if servers == nil then
          servers = c.name
        else
          servers = servers .. ", " .. c.name
        end
      end
    end
    if servers == nil then
      return ""
    end
    return servers
  end,
  icon = "",
  color = { fg = "#cfc95f", gui = "bold" },
}

require("lualine").setup({
  options = {
    globalstatus = true,
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
  },
  sections = {
    lualine_b = {
      "branch",
      "diff",
      "diagnostics",
      get_active_lsp_clients,
    },
    lualine_y = { "progress", "location" },
    lualine_z = { char_under_cursor },
  },
  extensions = { "neo-tree", "quickfix" },
})
