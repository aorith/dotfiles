return {
  cmd = { "pylsp" },
  settings = {
    pylsp = {
      configurationSources = { "pylint" },
      plugins = {
        pylint = {
          enabled = true,
          args = { "--ignore=E501,C0116", "-" },
        },
        flake8 = {
          enabled = true,
          ignore = { "E203", "W503", "E501" },
        },
        pylsp_mypy = { enabled = true },
        pycodestyle = {
          enabled = true,
          ignore = { "E231", "E203" },
          maxLineLength = 120,
        },
        pyflakes = { enabled = false },
      },
    },
  },
}
