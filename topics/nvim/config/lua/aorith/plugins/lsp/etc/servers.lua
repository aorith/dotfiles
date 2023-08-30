-- lspconfig_server_name = { enabled = <boolean>, config = <config> }

return {
  -- use shfmt and shellcheck instead
  -- bashls = { config = { cmd = { "@bashls@/bin/bash-language-server", "start" } } },

  nil_ls = { config = {} },
  gopls = { config = {} },
  sqlls = { config = {} },
  tflint = { config = {} },
  yamlls = {
    config = {
      settings = { yaml = { keyOrdering = false } },
    },
  },
  tsserver = { config = {} },
  terraformls = { config = {} },
  marksman = { config = {} },

  lua_ls = {
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
            -- Make the server aware of Neovim runtime files and plugins
            library = vim.api.nvim_get_runtime_file("lua", true),
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
    enabled = true,
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
  ruff_lsp = {
    enabled = true,
    config = {
      init_options = {
        settings = {},
      },
    },
  },
}
