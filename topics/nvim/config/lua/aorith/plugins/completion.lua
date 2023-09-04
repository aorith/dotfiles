return {
  "hrsh7th/nvim-cmp",
  enabled = true,
  event = "InsertEnter",

  dependencies = {
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",

    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",

    "onsails/lspkind.nvim",
  },

  opts = function()
    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")

    vim.opt.completeopt = "menu,menuone,noselect"
    local cmp_borders = cmp.config.window.bordered()

    return {
      window = {
        completion = cmp_borders,
        documentation = cmp_borders,
      },

      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm({ select = false }),

        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "buffer", keyword_length = 3 },
        { name = "path" },
        --{ name = "luasnip" },
        --{ name = "treesitter" },
      }),

      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol_text",
          maxwidth = 55,
          ellipsis_char = "…",
        }),
      },
    }
  end,
}
