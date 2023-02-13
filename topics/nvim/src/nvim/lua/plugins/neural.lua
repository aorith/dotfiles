if vim.env.OPENAI_API_KEY then
  return {
    "dense-analysis/neural",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "elpiloto/significant.nvim",
    },
    config = function()
      require("neural").setup({
        source = {
          openai = {
            api_key = vim.env.OPENAI_API_KEY,
          },
        },
      })
    end,
  }
else
  return {}
end
