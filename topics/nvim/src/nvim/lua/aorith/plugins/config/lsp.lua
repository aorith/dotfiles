-- disable virtual_text (inline) diagnostics and use floating window
-- format the message such that it shows source, message and
vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    float = {
        border = "double",
        format = function(diagnostic)
            return string.format(
                "%s (%s) [%s]",
                diagnostic.message,
                diagnostic.source,
                diagnostic.code or diagnostic.user_data.lsp.code
            )
        end,
    },
})

-- LSP Server configs
local lspconfig = require "lspconfig"
local util = require "lspconfig.util"

local servers = {
    sumneko_lua = {
        settings = {
            Lua = {
                runtime = {
                    -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
                    version = 'LuaJIT',
                },
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { 'vim' },
                },
                workspace = {
                    -- Make the server aware of Neovim runtime files
                    library = vim.api.nvim_get_runtime_file("", true),
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    },
    pylsp = {
        cmd = { "pylsp" },
        root_dir = function(fname)
            local root_files = {
                'pyproject.toml',
                'setup.py',
                'setup.cfg',
                'requirements.txt',
                'Pipfile',
                '.git/config',
            }
            return util.root_pattern(unpack(root_files))(fname) or util.find_git_ancestor(fname)
        end,
        settings = {
            pylsp = {
                configurationSources = { "pylint" },
                plugins = {
                    pylint = {
                        enabled = true,
                        args = { '--ignore=E501,C0116', '-' },
                    },
                    flake8 = {
                        enabled = true,
                        ignore = { "E203", "W503", "E501" },
                    },
                    pylsp_mypy = { enabled = true },
                    pycodestyle = {
                        enabled = true,
                        ignore = { 'E231', 'E203' },
                        maxLineLength = 120
                    },
                    pyflakes = { enabled = false },
                }
            }
        }
    },
}

local client_capabilities = vim.lsp.protocol.make_client_capabilities()
client_capabilities.textDocument.completion.completionItem.snippetSupport = true
client_capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { 'documentation', 'detail', 'additionalTextEdits' },
}
-- for nvim_cmp
client_capabilities = require('cmp_nvim_lsp').default_capabilities(client_capabilities)

for server, config in pairs(servers) do
    if type(config) == 'function' then
        config = config()
    end
    config.on_attach = on_attach
    config.capabilities = vim.tbl_deep_extend(
        'keep',
        config.capabilities or {},
        client_capabilities
    )
    lspconfig[server].setup(config)
end
