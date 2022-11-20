require("plugins.config.lsp.handlers").setup()
require("plugins.config.lsp.mason")
require("plugins.config.lsp.null-ls")

local _M = {}

_M.custom_server_capabilities = function()
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
      vim.inspect(
        vim.lsp.get_active_clients()[active_client_map[choice]].server_capabilities.executeCommandProvider
      )
    )
    vim.pretty_print(vim.lsp.get_active_clients()[active_client_map[choice]].server_capabilities)
  end)
end

vim.cmd("command! CheckLspServerCapabilities :lua =require('plugins.config.lsp').custom_server_capabilities()")

return _M
