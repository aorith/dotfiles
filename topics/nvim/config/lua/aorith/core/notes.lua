map("n", "<leader>nn", function()
  -- local note_name = vim.fn.input({ prompt = "New note: " })
  -- if not note_name or note_name == "" then return end
  -- vim.api.nvim_command("edit " .. notes_dir .. "/" .. note_name)
  vim.ui.input({ prompt = "Note name: " }, function(input)
    if not input or input == "" then return end
    vim.api.nvim_command("edit " .. notes_dir .. "/" .. input)
  end)
end, { desc = "New Note" })

map(
  "n",
  "<leader>ns",
  function() vim.api.nvim_command("edit " .. notes_dir .. "/core.scratch.md") end,
  { desc = "Open Scratch" }
)

map(
  "n",
  "<leader>ni",
  function() vim.api.nvim_command("edit " .. notes_dir .. "/core.interesting.md") end,
  { desc = "Open Interesting" }
)

map(
  "n",
  "<leader>nt",
  function() vim.api.nvim_command("edit " .. notes_dir .. "/core.todo.md") end,
  { desc = "Open To-Do" }
)

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
