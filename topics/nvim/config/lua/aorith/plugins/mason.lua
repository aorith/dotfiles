return {
  "williamboman/mason.nvim",
  build = ":MasonUpdate",

  config = function()
    local tools = {
      -- Formatters
      "stylua",
      "shfmt",
      "black",
      "isort",
      "ruff",

      -- Linters
      "typos",
      "vale",
      "proselint",
      "djlint",
      "golangci-lint",
      "yamllint",

      -- LSP
      "lua-language-server",
      "nil",
      "bash-language-server",
      "gopls",
      "sqlls",
      "yaml-language-server",
      "terraform-ls",
      "marksman",
      "ruff-lsp",
      "pyright",
      "eslint-lsp",
      "html-lsp",
      "css-lsp",
    }

    require("mason").setup()
    local mr = require("mason-registry")

    local function ensure_installed()
      for _, tool in ipairs(tools) do
        local p = mr.get_package(tool)
        if not p:is_installed() then p:install() end
      end
    end

    if mr.refresh then mr.refresh(ensure_installed) end

    ensure_installed()
  end,
}
