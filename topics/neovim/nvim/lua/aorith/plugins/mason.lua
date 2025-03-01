local ensure_installed = {
  -- "kcl", -- (installed via homebrew)
  "jsonnet-language-server",
  "autotools-language-server",
}

require("mason").setup({ ensure_installed = ensure_installed })

---@diagnostic disable-next-line:undefined-field
vim.uv.new_timer():start(
  5000,
  0,
  vim.schedule_wrap(function()
    local mr = require("mason-registry")

    local function install_tools()
      for _, tool in ipairs(ensure_installed) do
        local p = mr.get_package(tool)
        if not p:is_installed() then p:install() end
      end
    end

    if mr.refresh then
      mr.refresh(install_tools)
    else
      install_tools()
    end
  end)
)
