return {
  "romgrk/barbar.nvim",
  lazy = false,
  dependencies = {
    "lewis6991/gitsigns.nvim", -- OPTIONAL: for git status
    "nvim-tree/nvim-web-devicons", -- OPTIONAL: for file icons
  },
  init = function()
    vim.g.barbar_auto_setup = false
  end,

  opts = {
    animation = false,
    icons = {
      buffer_index = true,
    },
    sidebar_filetypes = {
      ["neo-tree"] = { event = "BufWipeout" },
      NvimTree = true,
      undotree = { text = "undotree" },
    },
  },
  keys = {
    { "<TAB>", "<cmd>BufferNext<CR>", mode = "n", desc = "Next Buffer" },
    { "<S-TAB>", "<cmd>BufferPrevious<CR>", mode = "n", desc = "Previous Buffer" },
    { "<leader><TAB>", "<cmd>BufferNext<CR>", mode = "n", desc = "Next Buffer" },
    { "<leader><S-TAB>", "<cmd>BufferPrevious<CR>", mode = "n", desc = "Previous Buffer" },
    { "<leader>1", "<Cmd>BufferGoto 1<CR>", mode = "n", desc = "Buffer 1" },
    { "<leader>2", "<Cmd>BufferGoto 2<CR>", mode = "n", desc = "Buffer 2" },
    { "<leader>3", "<Cmd>BufferGoto 3<CR>", mode = "n", desc = "Buffer 3" },
    { "<leader>4", "<Cmd>BufferGoto 4<CR>", mode = "n", desc = "Buffer 4" },
    { "<leader>5", "<Cmd>BufferGoto 5<CR>", mode = "n", desc = "Buffer 5" },
    { "<leader>6", "<Cmd>BufferGoto 6<CR>", mode = "n", desc = "Buffer 6" },
    { "<leader>7", "<Cmd>BufferGoto 7<CR>", mode = "n", desc = "Buffer 7" },
    { "<leader>8", "<Cmd>BufferGoto 8<CR>", mode = "n", desc = "Buffer 8" },
    { "<leader>9", "<Cmd>BufferGoto 9<CR>", mode = "n", desc = "Buffer 9" },
    { "<leader>0", "<Cmd>BufferLast<CR>", mode = "n", desc = "Buffer Last" },
    { "<leader>bP", "<Cmd>BufferPin<CR>", mode = "n", desc = "Pin Buffer" },
    { "<leader>q", "<Cmd>BufferClose<CR>", mode = "n", desc = "Close Buffer" },
    { "<leader>bp", "<Cmd>BufferPick<CR>", mode = "n", desc = "Pick Buffers" },
    { "<Space>bn", "<Cmd>BufferOrderByBufferNumber<CR>", mode = "n", desc = "Order by Number" },
    { "<Space>bd", "<Cmd>BufferOrderByDirectory<CR>", mode = "n", desc = "Order by Directory" },
    { "<Space>bl", "<Cmd>BufferOrderByLanguage<CR>", mode = "n", desc = "Order by Language" },
    { "<Space>bw", "<Cmd>BufferOrderByWindowNumber<CR>", mode = "n", desc = "Order by Window Number" },
  },
}
