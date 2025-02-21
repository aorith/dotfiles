return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "folke/lazydev.nvim",
    "kcl-lang/kcl.nvim",
  },

  config = function()
    -- Log level
    vim.lsp.set_log_level(vim.log.levels.OFF)

    -- Diagnostics
    vim.diagnostic.config({
      signs = { priority = 9999 },
      underline = true,
      update_in_insert = false, -- false so diags are updated on InsertLeave
      virtual_text = { severity = { min = "ERROR" } },
      severity_sort = true,
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = true,
        header = "",
      },
    })

    -- common handlers
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

    local on_attach = function(client, bufnr)
      -- disable some more capabilities
      if client.name == "pylsp" then
        client.server_capabilities.renameProvider = false
        client.server_capabilities.rename = false
      end

      -- disable semantic tokens
      -- currently it messes the highlighting, when I open a tf file it changes after a few seconds
      if client.name == "terraformls" then client.server_capabilities.semanticTokensProvider = nil end

      -- Set up 'mini.completion' LSP part of completion
      vim.bo[bufnr].omnifunc = "v:lua.MiniCompletion.completefunc_lsp"

      -- notify attachment
      ---@diagnostic disable-next-line: param-type-mismatch
      vim.notify(client.name .. " started", vim.log.levels.INFO, {
        -- title = "Attaching LSP",
        timeout = 3000,
      })
    end

    -- capabilities
    local capabilities = vim.tbl_deep_extend("force", vim.lsp.protocol.make_client_capabilities(), {
      textDocument = {
        completion = {
          completionItem = {
            -- Fetch additional info for completion items
            resolveSupport = {
              properties = {
                "documentation",
                "detail",
              },
            },
          },
        },
      },
    })

    -- Load LSP
    local lspconfig = require("lspconfig")
    local util = require("lspconfig.util")

    lspconfig.nil_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      -- settings = { ["nil"] = { formatting = { command = { "nixpkgs-fmt" } } } },
    })

    lspconfig.bashls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.gopls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.yamlls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      on_init = function() require("aorith.core.yaml_schema").get_client() end,

      settings = {
        redhat = { telemetry = { enabled = false } },

        yaml = {
          validate = true,
          format = { enable = true },
          keyOrdering = false,
          hover = true,
          completion = true,

          schemaStore = {
            enable = false,
            url = "https://www.schemastore.org/api/json/catalog.json",
          },

          -- schemas detected by filename
          schemas = {
            ["https://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}",
            ["https://raw.githubusercontent.com/docker/compose/master/compose/config/compose_spec.json"] = "{docker-,}compose*.{yml,yaml}",
            ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json"] = "argocd-application.{yml,yaml}",
            ["https://json.schemastore.org/github-workflow.json"] = ".github/workflows/*.{yml,yaml}",
          },

          -- custom option to select schemas by name with 'YAMLSchemaSelect' (aorith.core.yaml_schema)
          -- [<uri>] = <name>
          custom_schemas = {
            ["kubernetes"] = "kubernetes",
            ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.25.16-standalone-strict/all.json"] = "k8s-1.25.16",
            ["https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.31.4-standalone-strict/all.json"] = "k8s-1.31.4",
          },
        },
      },
    })

    lspconfig.terraformls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.marksman.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.lua_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          runtime = {
            version = "LuaJIT",
          },
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })

    lspconfig.basedpyright.setup({
      capabilities = capabilities,
      on_attach = on_attach,
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

    -- TODO: it seems to disable basedpyright documentation (priority thing?)
    -- lspconfig.ruff.setup({
    --   capabilities = capabilities,
    --   on_attach = on_attach,
    -- })

    lspconfig.ts_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.html.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.cssls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.templ.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.zk.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    -- go install github.com/grafana/jsonnet-language-server@latest
    lspconfig.jsonnet_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.helm_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        ["helm-ls"] = {
          yamlls = {
            path = "yaml-language-server",
          },
        },
      },
    })

    lspconfig.kcl.setup({
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = { "kcl-language-server" },
      filetypes = { "kcl" },
      root_dir = util.root_pattern("kcl.mod"),
    })

    lspconfig.cue.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })

    lspconfig.autotools_ls.setup({
      capabilities = capabilities,
      on_attach = on_attach,
    })
  end,
}
