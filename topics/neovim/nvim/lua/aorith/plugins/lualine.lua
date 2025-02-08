local M = {}

M.attached_lsp = {}

M.create_custom_autocommands = function()
  local gr = vim.api.nvim_create_augroup("CustomMiniStatusline", {})

  local au = function(event, pattern, callback, desc) vim.api.nvim_create_autocmd(event, { group = gr, pattern = pattern, callback = callback, desc = desc }) end

  -- Use `schedule_wrap()` because at `LspDetach` server is still present
  local track_lsp = vim.schedule_wrap(function(data)
    M.attached_lsp[data.buf] = M.compute_attached_lsp(data.buf)
    vim.cmd("redrawstatus")
  end)

  au({ "LspAttach", "LspDetach" }, "*", track_lsp, "Track LSP clients")
end

M.compute_attached_lsp = function(buf_id)
  local buf_clients = vim.lsp.get_clients({ bufnr = buf_id })
  if #buf_clients == 0 then return "{}" end

  local unique_buf_client_names = {}
  for _, client in pairs(buf_clients) do
    if not unique_buf_client_names[client.name] then unique_buf_client_names[client.name] = true end
  end

  local client_names = {}
  for key in pairs(unique_buf_client_names) do
    table.insert(client_names, key)
  end

  return "{" .. table.concat(client_names, " ") .. "}"
end

M.section_lsp = function() return M.attached_lsp[vim.api.nvim_get_current_buf()] or "{}" end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",

  init = function() M.create_custom_autocommands() end,

  opts = {
    options = {
      theme = "auto",
      section_separators = "",
      component_separators = "",
      globalstatus = true,
      disabled_filetypes = { statusline = { "dashboard", "alpha", "ministarter", "snacks_dashboard" } },
    },

    extensions = { "quickfix", "lazy" },

    sections = {
      lualine_a = { { "mode", fmt = function(str) return str:sub(1, 1) end } },
      lualine_b = { "branch", "diff", "diagnostics" },
      lualine_c = { { "filename", path = 1 } },
      lualine_x = { { M.section_lsp }, "encoding", "fileformat", "filetype" },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
  },
}
