local wk = require("which-key")
wk.setup({})

wk.register({
  g = {
    name = "Git",
  },
  f = {
    name = "Telescope",
  },
  l = {
    name = "Lsp",
    g = {
      name = "GO TO",
    },
  },
  w = {
    name = "Workspaces",
  },
}, {
  prefix = "<leader>",
})
