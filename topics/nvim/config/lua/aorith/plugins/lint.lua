local lint = require("lint")

lint.linters_by_ft = {
  go = { "golangcilint" },
  htmldjango = { "djlint" },
  jinja = { "djlint" },
  nix = { "nix" },
  python = { "ruff" },
  yaml = { "yamllint" },

  lua = {},
  markdown = {},
  sh = {},
}

-- Add typos to the above fts
for ft, _ in pairs(lint.linters_by_ft) do
  table.insert(lint.linters_by_ft[ft], "typos")
end

vim.api.nvim_create_autocmd({ "BufEnter", "BufReadPost", "BufWritePost", "TextChanged", "InsertLeave" }, {
  group = vim.api.nvim_create_augroup("Nvim-Lint", { clear = true }),
  callback = function(args)
    -- Ignore 3rd party code.
    if args.file:match("/(node_modules|__pypackages__|site_packages)/") then
      return
    end

    lint.try_lint()
  end,
})
