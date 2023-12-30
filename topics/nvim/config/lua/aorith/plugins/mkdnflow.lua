local notes_dir = "~/Syncthing/SYNC_STUFF/notes/main"

-- Global keymaps
map("n", "<leader>nf", function() require("telescope.builtin").find_files({ cwd = notes_dir }) end, { desc = "Find" })
map(
  "n",
  "<leader>ng",
  function() require("telescope.builtin").live_grep({ cwd = notes_dir, layout_strategy = "horizontal" }) end,
  { desc = "Grep ALL" }
)

return {
  "jakewvincent/mkdnflow.nvim",
  config = function()
    require("mkdnflow").setup({
      modules = {
        bib = false,
        buffers = false,
        conceal = true,
        cursor = true,
        folds = true,
        links = true,
        lists = true,
        maps = true,
        paths = true,
        tables = true,
        yaml = false,
      },
      perspective = {
        priority = "root",
        fallback = "first",
        root_tell = "index.md",
        nvim_wd_heel = true,
        update = true,
      },
      new_file_template = { use_template = true },
      tables = {
        trim_whitespace = true,
        format_on_move = true,
        auto_extend_rows = true,
        auto_extend_cols = true,
      },
      mappings = {
        MkdnEnter = { "v", "<cr>" },
        MkdnFollowLink = { "n", "<cr>" },
        MkdnIncreaseHeading = { "n", "+" },
        MkdnDecreaseHeading = { "n", "_" },
        MkdnToggleToDo = { "n", "tt" },
      },
      to_do = {
        symbols = { " ", "-", "x" }, -- lowercase 'x' so prettier does not break to-do's
      },
    })
  end,
}
