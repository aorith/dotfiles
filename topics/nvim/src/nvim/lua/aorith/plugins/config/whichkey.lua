local wk = require("which-key")

wk.register({
    e = { "<cmd>NvimTreeToggle<CR>", "FileExplorer" },
    f = {
        name = "TELESCOPE",
        f = { "<cmd>Telescope find_files<CR>", "Find Files" },
        g = { "<cmd>Telescope live_grep<CR>", "Live Grep" },
        l = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Fuzzy find in current Buffer" },
        b = { "<cmd>Telescope buffers<CR>", "Buffers" },
    },

    l = {
        name = "LSP",
        h = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover Info" },
        l = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Show line diagnostics" },
        e = { "<cmd>Telescope diagnostics<CR>", "Find Diagnostics" },
        c = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Show code actions" },
        f = { "<cmd>lua vim.lsp.buf.format { async = true }<CR>", "Format" },
        r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
        j = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Go to next diagnostic" },
        k = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Go to previous diagnostic" },
        d = {
            name = "DEFINITIONS",
            d = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
            c = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration" },
            r = { "<cmd>lua vim.lsp.buf.references()<CR>", "Find references" },
            t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Get type definition" },
        },
    },
},
    {
        prefix = "<leader>"
    })
