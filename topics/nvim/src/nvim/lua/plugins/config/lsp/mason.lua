local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")

local servers = { "sumneko_lua", "pyright", "bashls", "gopls", "jsonls", "tflint", "yamlls", "html", "cssls", "tsserver" }

local settings = {
  ui = {
    border = "rounded",
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup {
  ensure_installed = servers,
  automatic_installation = true,
}

local lspconfig = require("lspconfig")
local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("plugins.config.lsp.handlers").on_attach,
    capabilities = require("plugins.config.lsp.handlers").capabilities,
  }

  server = vim.split(server, "@")[1]
  local server_config_exists, server_config = pcall(require, "plugins.config.lsp.servers." .. server)
  if server_config_exists then
    opts = vim.tbl_deep_extend("force", server_config, opts)
  end

  lspconfig[server].setup(opts)
end
