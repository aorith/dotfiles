local wk = require("which-key")

wk.register({
    f = {
        f = { "<cmd>Telescope find_files<CR>", "Find Files" },
        g = { "<cmd>Telescope live_grep<CR>", "Live Grep" },
        l = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Fuzzy find in current Buffer" },
        b = { "<cmd>Telescope buffers<CR>", "Buffers" },
    },

    l = {
        name = "LSP",
        h = { "<cmd>ALEHover<CR>", "Hover Info" },
        e = { "<cmd>Telescope diagnostics<CR>", "Find Diagnostics" },
        c = { "<cmd>ALECodeAction<CR>", "Show code actions" },
        r = { "<cmd>ALERename<CR>", "Rename" },
        j = { "<cmd>ALENextWrap<CR>", "Go to next diagnostic" },
        k = { "<cmd>ALEPreviousWrap<CR>", "Go to previous diagnostic" },
        d = {
            name = "DEFINITIONS",
            d = { "<cmd>ALEGoToDefinition<CR>", "Go to definition" },
            c = { "<cmd>ALEGoToImplementation<CR>", "Go to implementation" },
            r = { "<cmd>ALEFindReferences<CR>", "Find references" },
            t = { "<cmd>ALEGoToTypeDefinition<CR>", "Get type definition" },
        },
    },
}, { prefix = "<leader>" })

-- ALE
--vim.cmd("set omnifunc=ale#completion#OmniFunc")
