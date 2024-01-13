map("n", "<leader>cv", "<cmd>GpWhisperAppend<cr>", { desc = "Voice Command" })
map("x", "<leader>cv", "<cmd>GpWhisperRewrite<cr>", { desc = "Voice Command" })
map("n", "<leader>ca", "<cmd>GpAppend<cr>", { desc = "Text Command" })
map("x", "<leader>ca", "<cmd>ChatGPTEditWithInstructions<cr>", { desc = "Edit with instructions" })
map("n", "<leader>cc", "<cmd>GpChatToggle<cr>", { desc = "Toggle Chat" })

return {
  {
    "jackMort/ChatGPT.nvim",
    lazy = true,
    cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTEditWithInstructions", "ChatGPTRun" },

    config = function()
      require("chatgpt").setup({
        api_key_cmd = "timeout 10 pass show Tokens/openai",
        popup_input = {
          submit = "<C-g>",
        },
      })
    end,
  },

  {
    "robitx/gp.nvim",
    lazy = true,
    cmd = { "GpWhisperPopup", "GpWhisperAppend", "GpWhisperRewrite", "GpChatToggle", "GpAppend" },

    config = function()
      require("gp").setup({
        openai_api_key = { "timeout", "10", "pass", "show", "Tokens/openai" },
      })
    end,
  },
}
