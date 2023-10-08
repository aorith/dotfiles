local utils = require("aorith.core.utils")
local prettier = { "prettierd", "prettier" }
local map = vim.keymap.set

local opts = {
  formatters_by_ft = {
    jinja = { "djlint" },
    htmldjango = { "djlint" },

    css = { prettier },
    graphql = { prettier },
    html = { prettier },
    javascript = { prettier },
    javascriptreact = { prettier },
    json = { prettier },
    jsonc = { prettier },
    markdown = { prettier },
    terraform = { "terraform_fmt", "trim_newlines", "trim_whitespace" },
    typescript = { prettier },
    typescriptreact = { prettier },
    yaml = { prettier },

    go = { "goimports", "gofmt" },
    lua = { "stylua" },
    nix = { "alejandra" },
    python = { "ruff", "black" },

    sh = { "shfmt" },
    bash = { "shfmt" },
  },
  log_level = vim.log.levels.ERROR,
  notify_on_error = true,
}

---@diagnostic disable: param-type-mismatch
vim.list_extend(require("conform.formatters.shfmt").args, { "--indent", "4" })
vim.list_extend(require("conform.formatters.ruff").args, { "--ignore", "F841" }) -- avoid ruff deleting unused variables
vim.list_extend(
  require("conform.formatters.stylua").args,
  { "--config-path", vim.fn.getenv("XDG_CONFIG_HOME") .. "/" .. utils.nvim_appname .. "/stylua.toml" }
)

require("conform").setup(opts)

map(
  "n",
  "<leader>lf",
  function() require("conform").format({ async = false, lsp_fallback = true, timeout_ms = 5000 }) end,
  { desc = "Format buffer" }
)
map(
  "v",
  "<leader>lf",
  function() require("conform").format({ async = false, lsp_fallback = true, timeout_ms = 5000 }) end,
  { desc = "Format buffer" }
)
