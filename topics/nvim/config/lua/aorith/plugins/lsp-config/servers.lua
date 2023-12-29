local M = {}

local on_attach = function(client, bufnr)
  -- disable some more capabilities
  if client.name == "pylsp" then
    client.server_capabilities.renameProvider = false
    client.server_capabilities.rename = false
  end

  -- disable hover in favor of pyright
  if client.name == "ruff_lsp" then client.server_capabilities.hoverProvider = false end
end

--local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = require("cmp_nvim_lsp").default_capabilities()

M.setup = function()
  require("neodev").setup() -- make sure to setup neodev BEFORE lspconfig
  local lspconfig = require("lspconfig")

  lspconfig.nil_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    -- settings = { ["nil"] = { formatting = { command = { "nixpkgs-fmt" } } } },
  })

  lspconfig.bashls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "sh", "bash" },
  })

  lspconfig.gopls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.sqlls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.yamlls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = { yaml = { keyOrdering = false } },
  })

  lspconfig.terraformls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.marksman.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.lua_ls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
          path = vim.split(package.path, ";"),
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files and plugins
          library = { vim.env.VIMRUNTIME },
          checkThirdParty = false,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  })

  lspconfig.pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      {
        python = {
          analysis = {
            autoSearchPaths = true,
            diagnosticMode = "workspace",
            useLibraryCodeForTypes = true,
          },
        },
      },
    },
  })

  lspconfig.ruff_lsp.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.tsserver.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.html.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })

  lspconfig.cssls.setup({
    on_attach = on_attach,
    capabilities = capabilities,
  })
end

return M
