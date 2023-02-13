return {
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")

      local servers = require("plugins.config.lsp.servers")
      local server_names = vim.tbl_keys(servers)
      local ensure_installed = {}
      for _, k in pairs(server_names) do
        if k == "sumneko_lua" then
          table.insert(ensure_installed, "lua_ls")
        else
          table.insert(ensure_installed, k)
        end
      end

      mason.setup({
        ui = {
          border = "rounded",
        },
        log_level = vim.log.levels.INFO,
        max_concurrent_installers = 4,
      })

      mason_lspconfig.setup({
        ensure_installed = ensure_installed,
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
    end,
  },
}
