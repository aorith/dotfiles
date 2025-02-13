return {
  "mfussenegger/nvim-lint",
  opts = {},

  config = function(_, opts)
    local lint = require("lint")

    lint.linters_by_ft = {
      --python = { "ruff" }, -- ruff already lints with ruff lsp
      ansible = { "ansible_lint" },
      go = { "golangcilint" },
      htmldjango = { "djlint" },
      jinja = { "djlint" },
      nix = { "nix" },
      terraform = { "tflint" },
      hcl = { "tflint" },
      yaml = { "yamllint" },
      cue = { "cue" },
    }

    vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
      group = vim.api.nvim_create_augroup("Nvim-Lint", { clear = true }),
      callback = function()
        lint.try_lint()

        if vim.bo.filetype ~= "bigfile" then
          lint.try_lint("typos") -- run on all files
        end
      end,
    })
  end,
}
