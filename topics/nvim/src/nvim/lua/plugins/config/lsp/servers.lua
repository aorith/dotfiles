return {
  pyright = {},
  bashls = {},
  gopls = {},
  jsonls = {},
  tflint = {},
  yamlls = {},
  html = {},
  cssls = {},
  tsserver = {},

  sumneko_lua = {
    settings = {
      Lua = {
        runtime = {
          -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
          version = "LuaJIT",
        },
        format = { enable = true },
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

  pylsp = {
    cmd = { "pylsp" },
    settings = {
      pylsp = {
        configurationSources = { "pylint" },
        plugins = {
          pylint = {
            enabled = true,
            args = { "--ignore=E501,C0116", "-" },
          },
          flake8 = {
            enabled = true,
            ignore = { "E203", "W503", "E501" },
          },
          pylsp_mypy = { enabled = true },
          pycodestyle = {
            enabled = true,
            ignore = { "E231", "E203" },
            maxLineLength = 120,
          },
          pyflakes = { enabled = false },
        },
      },
    },
  }
}
