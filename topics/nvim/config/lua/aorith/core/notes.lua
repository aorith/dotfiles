map(
  "n",
  "<leader>ni",
  function() vim.api.nvim_command("edit " .. notes_dir .. "/index.md") end,
  { desc = "Open Index" }
)

map("n", "<leader>nt", function() vim.api.nvim_command("edit " .. notes_dir .. "/todo.md") end, { desc = "Open To-Do" })

map("n", "<leader>nf", function() require("telescope.builtin").find_files({ cwd = notes_dir }) end, { desc = "Find" })

map(
  "n",
  "<leader>ng",
  function()
    require("telescope.builtin").live_grep({
      cwd = notes_dir,
      layout_strategy = "horizontal",
      additional_args = { "-i" },
    })
  end,
  { desc = "Grep ALL" }
)
