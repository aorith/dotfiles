return {
  "jose-elias-alvarez/null-ls.nvim",
  config = function()
    local utils = require("aorith.core.utils")
    local null_ls = require("null-ls")
    local null_ls_utils = require("null-ls.utils")

    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
    local formatting = null_ls.builtins.formatting
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
    local diagnostics = null_ls.builtins.diagnostics
    local code_actions = null_ls.builtins.code_actions

    -- Null-Ls sources
    -- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
    local null_ls_sources = {
      code_actions.gitsigns,
      code_actions.refactoring,
      null_ls.builtins.hover.printenv,
      null_ls.builtins.hover.dictionary,

      -- actions
      --code_actions.shellcheck,

      -- formatting
      --formatting.shfmt.with({extra_args = { "--indent", "4" },filetypes = { "sh", "bash" },}),
      formatting.alejandra,
      formatting.jq,
      formatting.prettier,
      formatting.terraform_fmt,
      formatting.yamlfmt,
      formatting.stylua.with({
        extra_args = {
          "--config-path",
          vim.fn.getenv("XDG_CONFIG_HOME") .. "/" .. utils.nvim_appname .. "/stylua.toml",
        },
      }),
      formatting.black,
      --formatting.isort,
      -- TODO: https://github.com/charliermarsh/ruff/issues/1904
      -- use this instead of black and isort when its ready
      formatting.ruff.with({
        extra_args = { "--ignore", "F841" }, -- avoid ruff deleting unused variables
      }),

      -- diagnostics
      diagnostics.yamllint,
      diagnostics.golangci_lint,
      diagnostics.terraform_validate,
      --diagnostics.shellcheck,
    }

    null_ls.setup({
      sources = null_ls_sources,
      diagnostics_format = "#{m} (#{s})",
    })
  end,
}
