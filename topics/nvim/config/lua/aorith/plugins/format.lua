local utils = require("aorith.core.utils")

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = "ConformInfo",
  opts = {
    formatters_by_ft = {
      css = { "prettier" },
      html = { "prettier" },
      javascript = { "prettier" },
      javascriptreact = { "prettier" },
      typescript = { "prettier" },
      typescriptreact = { "prettier" },
      graphql = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      markdown = { "prettier" },
      yaml = { "prettier" },

      go = { "goimports", "gofmt" },
      lua = { "stylua" },
      nix = { "nixpkgs_fmt" },
      python = { "ruff", "black" },

      sh = { "shfmt" },
      bash = { "shfmt" },
    },
    log_level = vim.log.levels.ERROR,
  },

  config = function(_, opts)
    ---@diagnostic disable: param-type-mismatch
    vim.list_extend(require("conform.formatters.shfmt").args, { "--indent", "4" })
    vim.list_extend(require("conform.formatters.ruff").args, { "--ignore", "F841" }) -- avoid ruff deleting unused variables
    vim.list_extend(
      require("conform.formatters.stylua").args,
      { "--config-path", vim.fn.getenv("XDG_CONFIG_HOME") .. "/" .. utils.nvim_appname .. "/stylua.toml" }
    )

    require("conform").setup(opts)
  end,

  keys = {
    {
      "=",
      function()
        require("conform").format({ async = false, lsp_fallback = true })
      end,
      mode = "",
      desc = "Format buffer",
    },
    {
      "<leader>lf",
      function()
        require("conform").format({ async = false, lsp_fallback = true })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
}