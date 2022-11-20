require("nvim-treesitter.configs").setup({
  -- A list of parser names, or "all"
  ensure_installed = {
    "c",
    "lua",
    "python",
    "bash",
    "go",
    "css",
    "html",
    "json",
    "json5",
    "make",
    "nix",
    "sql",
    "toml",
    "vim",
    "yaml",
    "dockerfile",
    "gitignore",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,

  -- Automatically install missing parsers when entering buffer
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = {},

  indent = { enable = true },
  autotag = { enable = true },

  highlight = {
    enable = true,

    disable = function(lang, buf)
      local max_filesize = 4096 * 1024 -- 4 MB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end,

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
})
