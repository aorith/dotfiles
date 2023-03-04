local M = {}

local function macos_background()
  local output = vim.fn.system("defaults read -g AppleInterfaceStyle")
  if string.match(output, ".*Dark.*") then
    return "dark"
  else
    return "light"
  end
end

local function linux_background()
  return "dark"
end

function M.os_background()
  if vim.fn.has("macunix") == 1 then
    return macos_background()
  elseif vim.fn.has("unix") == 1 then
    return linux_background()
  end
  return "dark"
end

---@param silent boolean?
---@param values? {[1]:any, [2]:any}
function M.toggle(option, silent, values)
  local Util = require("lazy.core.util")
  if values then
    if vim.opt_local[option]:get() == values[1] then
      vim.opt_local[option] = values[2]
    else
      vim.opt_local[option] = values[1]
    end
    return Util.info("Set " .. option .. " to " .. vim.opt_local[option]:get(), { title = "Option" })
  end
  vim.opt_local[option] = not vim.opt_local[option]:get()
  if not silent then
    if vim.opt_local[option]:get() then
      Util.info("Enabled " .. option, { title = "Option" })
    else
      Util.warn("Disabled " .. option, { title = "Option" })
    end
  end
end

local enabled = true
function M.toggle_diagnostics()
  local Util = require("lazy.core.util")
  enabled = not enabled
  if enabled then
    vim.diagnostic.enable()
    Util.info("Enabled diagnostics", { title = "Diagnostics" })
  else
    vim.diagnostic.disable()
    Util.warn("Disabled diagnostics", { title = "Diagnostics" })
  end
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
    if choice == nil then
      return
    end
    local Popup = require("nui.popup")
    local event = require("nui.utils.autocmd").event

    local popup = Popup({
      buf_options = {
        filetype = "lua",
      },
      enter = true,
      focusable = true,
      border = {
        style = "rounded",
      },
      position = "50%",
      size = {
        width = "80%",
        height = "80%",
      },
    })

    -- mount/open the component
    popup:mount()

    -- unmount component when cursor leaves buffer
    popup:on(event.BufLeave, function()
      popup:unmount()
    end)

    local _ = popup:map("n", "q", function(bufnr)
      popup:unmount()
    end, { noremap = true })

    -- set content
    local lines = {}
    local raw_string = vim.inspect(vim.lsp.get_active_clients()[active_client_map[choice]].server_capabilities)
    for s in raw_string:gmatch("[^\r\n]+") do
      table.insert(lines, s)
    end
    vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, lines)
  end)
end

return M
