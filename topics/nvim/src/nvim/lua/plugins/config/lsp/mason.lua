local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

local servers = require("plugins.config.lsp.servers")
local server_names = vim.tbl_keys(servers)

mason.setup({
  ui = {
    border = "rounded",
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
})

mason_lspconfig.setup({
  ensure_installed = server_names,
  automatic_installation = true,
})

local lspconfig = require("lspconfig")
local opts = {}

for _, server in pairs(server_names) do
  opts = {
    on_attach = require("plugins.config.lsp.handlers").on_attach,
    capabilities = require("plugins.config.lsp.handlers").capabilities,
  }

  opts = vim.tbl_deep_extend("force", servers[server], opts)

  lspconfig[server].setup(opts)
end
