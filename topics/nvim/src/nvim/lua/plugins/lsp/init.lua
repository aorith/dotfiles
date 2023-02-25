return {
  -- lspconfig
  { "williamboman/mason.nvim", cmd = "Mason", lazy = false },
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = true },
      { "folke/neodev.nvim", opts = { experimental = { pathStrict = true } } },
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
    },

    config = function()
      -- On attach
      local on_attach = function(client, bufnr)
        vim.cmd("command! CheckLspServerCapabilities :lua =require('core.utils').custom_server_capabilities()")

        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, bufnr)
        end

        -- disable formatting to null-ls takes care
        if client.name == "sumneko_lua" or client.name == "lua_ls" then
          client.server_capabilities.documentFormattingProvider = false
          client.server_capabilities.documentRangeFormattingProvider = false
          client.server_capabilities.formatting = false
          client.server_capabilities.formatRange = false
        end

        -- disable some more capabilities
        if client.name == "pylsp" then
          client.server_capabilities.renameProvider = false
          client.server_capabilities.rename = false
        end

        require("plugins.lsp.keymaps").set_keymaps(bufnr)
      end

      -- Diagnostics
      vim.diagnostic.config({
        signs = true,
        underline = true,
        update_in_insert = false,
        virtual_text = { spacing = 4, prefix = "●" },
        severity_sort = true,
        float = {
          focusable = false,
          format = function(diagnostic)
            -- custom format message
            if diagnostic == nil then
              return "No diagnostics."
            end
            local code = ""
            if diagnostic.code ~= nil then
              code = diagnostic.code
            elseif diagnostic.user_data ~= nil then
              code = (diagnostic.user_data.lsp or { code = "" }).code or ""
            end
            return string.format("%s [%s]", diagnostic.message, code)
          end,
          border = "rounded",
          source = "always",
          header = "Diagnostics:",
          prefix = " ",
        },
      })

      -- List of servers and their configs
      local servers = require("plugins.lsp.servers")
      local server_names = vim.tbl_keys(servers)
      local ensure_installed = {}
      for _, k in pairs(server_names) do
        if servers[k].ensure_installed_name then
          table.insert(ensure_installed, servers[k].ensure_installed_name)
        else
          table.insert(ensure_installed, k)
        end
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

      -- actual function that setups the servers
      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          on_attach = on_attach,
          capabilities = vim.deepcopy(capabilities),
        }, servers[server].config or {})

        if servers[server].enabled == nil or servers[server].enabled then
          require("lspconfig")[server].setup(server_opts)
        end
      end

      require("mason").setup({
        pip = {
          upgrade_pip = false,
        },
      })
      require("mason-lspconfig").setup({ ensure_installed = ensure_installed })
      require("mason-lspconfig").setup_handlers({ setup })
    end,
  },

  -- formatters
  {
    "jose-elias-alvarez/null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "mason.nvim", "jay-babu/mason-null-ls.nvim" },
    config = function()
      local null_ls = require("null-ls")
      local null_ls_utils = require("null-ls.utils")
      local mason_null_ls = require("mason-null-ls")

      local exe_exists = function(exe_name)
        return vim.fn.executable(exe_name) == 1
      end

      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
      local formatting = null_ls.builtins.formatting
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
      local diagnostics = null_ls.builtins.diagnostics
      local code_actions = null_ls.builtins.code_actions

      mason_null_ls.setup({
        ensure_installed = {
          "jq",
          "prettier",
          "shellcheck",
          "shfmt",
          "black",
          "mypy",
          "flake8",
          "isort",
          "stylua",
        },
        automatic_installation = true,
      })

      -- Null-Ls sources
      -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
      local null_ls_sources = {
        code_actions.gitsigns,
        code_actions.refactoring,
        diagnostics.todo_comments,
        diagnostics.trail_space,
        null_ls.builtins.hover.printenv,
        null_ls.builtins.hover.dictionary,
      }

      if exe_exists("shellcheck") then
        table.insert(null_ls_sources, code_actions.shellcheck)
        table.insert(null_ls_sources, diagnostics.shellcheck)
      end
      --if exe_exists("mypy") then
      -- table.insert(null_ls_sources, diagnostics.mypy.with({ extra_args = { "--ignore-missing-imports" } }))
      --end
      if exe_exists("black") then
        table.insert(null_ls_sources, formatting.black)
      end
      if exe_exists("isort") then
        table.insert(null_ls_sources, formatting.isort)
      end
      if exe_exists("prettier") then
        table.insert(null_ls_sources, formatting.prettier)
      end
      if exe_exists("tidy") then
        table.insert(null_ls_sources, diagnostics.tidy)
      end
      if exe_exists("yamllint") then
        table.insert(null_ls_sources, diagnostics.yamllint)
      end
      if exe_exists("jq") then
        table.insert(null_ls_sources, formatting.jq)
      end
      if exe_exists("shfmt") then
        table.insert(
          null_ls_sources,
          formatting.shfmt.with({ extra_args = { "--indent", "4" }, filetypes = { "sh", "bash" } })
        )
      end
      if exe_exists("stylua") then
        table.insert(
          null_ls_sources,
          formatting.stylua.with({
            extra_args = { "--config-path", vim.fn.expand("~/.config/nvim/stylua.toml") },
          })
        )
      end

      null_ls.setup({
        root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git"),
        debug = false,
        sources = null_ls_sources,
      })
    end,
  },
}