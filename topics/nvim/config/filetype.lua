vim.filetype.add({
  pattern = {
    [".*.j2"] = "htmldjango",
    [".*.jinja"] = "htmldjango",
    [".*.jinja2"] = "htmldjango",
  },
})
