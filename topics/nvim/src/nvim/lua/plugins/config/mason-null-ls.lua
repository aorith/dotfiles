local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local null_ls = require("null-ls")
local null_ls_utils = require("null-ls.utils")
local mason_null_ls = require("mason-null-ls")

local exe_exists = function(exe_name)
    if vim.fn.empty(vim.fn.exepath(exe_name)) == 0 then
        return true
    end
    return false
end

mason.setup()
mason_lspconfig.setup({
    -- include the following servers in 'lsp.lua' servers list too
    ensure_installed = { "sumneko_lua", "pylsp", "bashls", "gopls", "jsonls", "tflint", "yamlls" },
})
-- manual installation for pylsp:
-- :PylspInstall pyls-flake8 pylsp-mypy pyls-isort

mason_null_ls.setup({
    ensure_installed = { "stylua", "jq", "prettier" },
})

mason_null_ls.setup_handlers({
    function(source_name)
        -- all sources with no handler get passed here
    end,
    stylua = function()
        null_ls.register(null_ls.builtins.formatting.stylua)
    end,
    jq = function()
        null_ls.register(null_ls.builtins.formatting.jq)
    end,
})

-- Null-Ls sources
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md
local null_ls_sources = {
    null_ls.builtins.code_actions.gitsigns,
    null_ls.builtins.code_actions.refactoring,
    null_ls.builtins.diagnostics.todo_comments,
    null_ls.builtins.diagnostics.trail_space,
    null_ls.builtins.hover.printenv,
    null_ls.builtins.hover.dictionary,
}
if exe_exists("shellcheck") then
    table.insert(null_ls_sources, null_ls.builtins.code_actions.shellcheck)
end
if exe_exists("mypy") then
    table.insert(null_ls_sources, null_ls.builtins.diagnostics.mypy)
end
if exe_exists("black") then
    table.insert(null_ls_sources, null_ls.builtins.formatting.black)
end
if exe_exists("isort") then
    table.insert(null_ls_sources, null_ls.builtins.formatting.isort)
end
if exe_exists("prettier") then
    table.insert(null_ls_sources, null_ls.builtins.formatting.prettier)
end
if exe_exists("stylua") then
    table.insert(null_ls_sources, null_ls.builtins.formatting.stylua)
end
if exe_exists("tidy") then
    table.insert(null_ls_sources, null_ls.builtins.diagnostics.tidy)
end
if exe_exists("yamllint") then
    table.insert(null_ls_sources, null_ls.builtins.diagnostics.yamllint)
end
if exe_exists("jq") then
    table.insert(null_ls_sources, null_ls.builtins.formatting.jq)
end
if exe_exists("shfmt") then
    table.insert(null_ls_sources, null_ls.builtins.formatting.shfmt)
end

null_ls.setup({
    root_dir = null_ls_utils.root_pattern(".stylua.toml", ".null-ls-root", "Makefile", ".git"),
    debug = false,
    sources = null_ls_sources,
})
