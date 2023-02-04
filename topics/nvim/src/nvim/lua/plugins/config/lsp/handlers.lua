local M = {}

local cmp_nvim_lsp = require("cmp_nvim_lsp")
M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}
M.capabilities = vim.tbl_deep_extend("force", M.capabilities, cmp_nvim_lsp.default_capabilities())
M.capabilities.textDocument.completion.completionItem.snippetSupport = true

M.setup = function()
  local custom_diagnostic_format = function(diagnostic)
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
  end

  local config = {
    -- disable virtual text
    virtual_lines = false,
    virtual_text = false,
    -- show signs
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      format = custom_diagnostic_format,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    -- width = 60,
    -- height = 30,
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
    -- width = 60,
    -- height = 30,
  })
end

local lsp_document_highlight_group = vim.api.nvim_create_augroup("lsp_document_highlight", {})
local lsp_highlight_document = function(bufnr)
  vim.api.nvim_create_autocmd("CursorHold", {
    buffer = bufnr,
    group = lsp_document_highlight_group,
    callback = function()
      vim.lsp.buf.document_highlight()
    end,
  })
  vim.api.nvim_create_autocmd("CursorMoved", {
    buffer = bufnr,
    group = lsp_document_highlight_group,
    callback = function()
      vim.lsp.buf.clear_references()
    end,
  })
end

M.custom_server_capabilities = function()
  local active_clients = vim.lsp.get_active_clients()
  local active_client_map = {}

  for index, value in ipairs(active_clients) do
    active_client_map[value.name] = index
  end

  vim.ui.select(vim.tbl_keys(active_client_map), {
    prompt = "Select client:",
    format_item = function(item)
      return "capabilites for: " .. item
    end,
  }, function(choice)
    print(
      vim.inspect(vim.lsp.get_active_clients()[active_client_map[choice]].server_capabilities.executeCommandProvider)
    )
    vim.pretty_print(vim.lsp.get_active_clients()[active_client_map[choice]].server_capabilities)
  end)
end

M.on_attach = function(client, bufnr)
  vim.cmd(
    "command! CheckLspServerCapabilities :lua =require('plugins.config.lsp.handlers').custom_server_capabilities()"
  )

  -- disable formatting to null-ls takes care
  if client.name == "sumneko_lua" then
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
  end

  if client.server_capabilities.documentHighlightProvider then
    lsp_highlight_document(bufnr)
  end

  -- Show line diagnostics automatically
  vim.api.nvim_create_autocmd({ "CursorHold" }, {
    group = vim.api.nvim_create_augroup("lsp_show_diagnostics_hover", {}),
    callback = function()
      -- do not open diag if another float is present
      for _, winid in pairs(vim.api.nvim_tabpage_list_wins(0)) do
        if vim.api.nvim_win_get_config(winid).zindex then
          return
        end
      end
      vim.diagnostic.open_float({ scope = "cursor" }, {})
    end,
  })

  require("core.keymaps").lsp_keymaps(bufnr)
end

return M
