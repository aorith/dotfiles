vim.filetype.add({
  pattern = {
    [".*.j2"] = "htmldjango",
    [".*.jinja"] = "htmldjango",
    [".*.jinja2"] = "htmldjango",
    [".*.html"] = function(path, bufnr)
      local result = -1
      vim.api.nvim_buf_call(bufnr, function() result = vim.fn.search("end }}") end)
      if result > 0 then return "gohtmltmpl" end
      return "html"
    end,
  },
})
