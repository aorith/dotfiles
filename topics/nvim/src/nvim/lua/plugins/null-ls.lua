return {
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = {
      "jayp0521/mason-null-ls.nvim",
    },
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
          "selene",
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
      if exe_exists("mypy") then
        table.insert(null_ls_sources, diagnostics.mypy.with({ extra_args = { "--ignore-missing-imports" } }))
      end
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
