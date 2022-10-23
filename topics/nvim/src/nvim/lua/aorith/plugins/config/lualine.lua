-- Bufferline
require("bufferline").setup({
    options = {
        mode = "buffers",
        numbers = "ordinal",
        diagnostics = true,
        offsets = {
            { filetype = "neo-tree", text = "File Explorer", text_align = "center" },
        },
    },
})

-- Lsp server name .
local char_under_cursor = {
    function()
        return "0x%B"
    end,
}

require("lualine").setup({
    options = {
        globalstatus = true,
    },
    sections = {
        lualine_y = { "progress", "location" },
        lualine_z = { char_under_cursor },
    },
    extensions = { "neo-tree", "quickfix" },
})
