-- lspconfig_server_name = { enabled = <boolean>, ensure_installed_name = <name>, config = <config> }

return {
  bashls = { config = {} },
  gopls = { config = {} },
  jsonls = { config = {} },
  tflint = { config = {} },
  yamlls = { config = {} },
  html = { config = {} },
  cssls = { config = {} },
  tsserver = { config = {} },
  docker_compose_language_service = {
    config = { filetypes = { "yaml", "yml" }, settings = { telemetry = { enableTelemetry = false } } },
  },
  dockerls = { config = {} },

  lua_ls = {
    ensure_installed_name = "lua_ls",
    config = {
      settings = {
        Lua = {
          runtime = {
            -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
            version = "LuaJIT",
          },
          completion = {
            callSnippet = "Replace",
          },
          format = { enable = false },
          diagnostics = {
            -- Get the language server to recognize the `vim` global
            globals = { "vim" },
          },
          workspace = {
            -- Make the server aware of Neovim runtime files
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
          telemetry = {
            enable = false,
          },
        },
      },
    },
  },

  pyright = {
    config = {
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
    },
  },
  pylsp = {
    enabled = true,
    config = {
      settings = {
        pylsp = {
          plugins = {
            autopep8 = { enabled = false },
            mccabe = { enabled = true },
            pylint = {
              enabled = true,
              args = { "--ignore=E501,C0116", "-" },
            },
            flake8 = {
              enabled = true,
              ignore = { "E203", "W503", "E501" },
            },
            pycodestyle = {
              enabled = true,
              ignore = { "E231", "E203", "W503" },
              maxLineLength = 120,
            },
            pyflakes = { enabled = false },
          },
        },
      },
    },
  },
}
