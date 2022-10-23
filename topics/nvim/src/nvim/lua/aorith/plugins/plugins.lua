require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    use("mhinz/vim-signify")
    use("fgsch/vim-varnish")
    use("sheerun/vim-polyglot")
    use("ojroques/nvim-osc52")
    use("psf/black")

    use({
        "nvim-telescope/telescope.nvim",
        requires = { { "nvim-lua/popup.nvim" }, { "nvim-lua/plenary.nvim" } },
    })
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

    use("neovim/nvim-lspconfig")
    use("nvim-treesitter/nvim-treesitter")

    use("hrsh7th/nvim-cmp")
    use("hrsh7th/cmp-nvim-lsp")
    use("hrsh7th/cmp-buffer")
    use("hrsh7th/cmp-path")
    use("hrsh7th/cmp-cmdline")
    use("hrsh7th/cmp-nvim-lua")
    use("hrsh7th/cmp-vsnip")
    use("hrsh7th/vim-vsnip")

    use({
        "folke/which-key.nvim",
        config = function()
            require("which-key").setup({})
        end,
    })

    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v2.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "kyazdani42/nvim-web-devicons", -- not strictly required, but recommended
            "MunifTanjim/nui.nvim",
            {
                -- only needed if you want to use the commands with "_with_window_picker" suffix
                "s1n7ax/nvim-window-picker",
                tag = "v1.*",
            },
        },
    })

    use({
        use("nvim-lualine/lualine.nvim"),
        requires = { "kyazdani42/nvim-web-devicons" },
    })
    use({ "akinsho/bufferline.nvim", tag = "v3.*", requires = "kyazdani42/nvim-web-devicons" })

    -- autoinstall language servers
    use({
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "jose-elias-alvarez/null-ls.nvim",
        "jayp0521/mason-null-ls.nvim",
    })

    -- themes
    use({ "jacoborus/tender.vim", opt = true })
    use({ "folke/tokyonight.nvim", opt = false })
    use({ "joshdick/onedark.vim", opt = true })
    use({ "rebelot/kanagawa.nvim", opt = false })
    use({ "sainnhe/gruvbox-material", opt = false })
    use({ "ellisonleao/gruvbox.nvim", opt = false })
end)

-- Configuration
local actions = require("telescope.actions")
require("telescope").load_extension("fzf")
require("telescope").setup({
    defaults = {
        prompt_prefix = " ",
        selection_caret = "❯ ",
        path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
            width = 0.87,
            height = 0.87,
            preview_cutoff = 120,
        },
        mappings = {
            i = {
                ["<C-n>"] = actions.cycle_history_next,
                ["<C-p>"] = actions.cycle_history_prev,
                ["<C-j>"] = actions.move_selection_next,
                ["<C-k>"] = actions.move_selection_previous,
            },
        },
    },
})

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = { "sumneko_lua", "pylsp" },
})
require("mason-null-ls").setup({
    ensure_installed = { "stylua", "jq" },
})
require("mason-null-ls").setup_handlers({
    function(source_name)
        -- all sources with no handler get passed here
    end,
    stylua = function()
        require("null-ls").register(require("null-ls").builtins.formatting.stylua)
    end,
    jq = function()
        require("null-ls").register(require("null-ls").builtins.formatting.jq)
    end,
})
require("null-ls").setup({
    root_dir = require("null-ls.utils").root_pattern(".stylua.toml", ".null-ls-root", "Makefile", ".git"),
})

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
require("neo-tree").setup({
    close_if_last_window = false,
    enable_diagnostics = true,
    source_selector = {
        winbar = true,
        statusline = false,
        content_layout = "center",
    },
    default_component_configs = {
        indent = {
            padding = 0,
        },
    },
    window = {
        position = "left",
        width = 40,
    },
    filesystem = {
        follow_current_file = true,
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
    },
    buffers = {
        follow_current_file = true,
    },
})

require("window-picker").setup({
    use_winbar = "smart",
    autoselect_one = true,
    include_current = false,
    filter_rules = {
        -- filter using buffer options
        bo = {
            -- if the file type is one of following, the window will be ignored
            filetype = { "neo-tree", "neo-tree-popup", "notify", "quickfix" },

            -- if the buffer type is one of following, the window will be ignored
            buftype = { "terminal" },
        },
    },
    other_win_hl_color = "#e35e4f",
})

-- rest of the configuration
require("aorith.plugins.config")
