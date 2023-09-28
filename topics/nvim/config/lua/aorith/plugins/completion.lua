vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

local cmp = require("cmp")
local defaults = require("cmp.config.default")()
local luasnip = require("luasnip")
local lspkind = require("lspkind")
local cmp_borders = cmp.config.window.bordered()

---@diagnostic disable-next-line: missing-fields
require("cmp").setup({
  window = {
    completion = cmp_borders,
    documentation = cmp_borders,
  },

  snippet = {
    expand = function(args) luasnip.lsp_expand(args.body) end,
  },

  mapping = cmp.mapping.preset.insert({
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item({ behavior = cmp.SelectBehavior.Insert })
      else
        fallback()
      end
    end),
    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
      else
        fallback()
      end
    end),

    ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
    ["<S-CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    }),
  }),

  sources = cmp.config.sources({
    { name = "nvim_lsp", priority = 99 },
    { name = "path" },
    { name = "nvim_lua" },
    { name = "luasnip" },
    { name = "treesitter" },
    { name = "buffer", keyword_length = 2, priority = 1 },
  }),

  ---@diagnostic disable-next-line: missing-fields
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      maxwidth = 55,
      ellipsis_char = "…",
    }),
  },

  experimental = {
    ghost_text = {
      hl_group = "CmpGhostText",
    },
  },
  sorting = defaults.sorting,
})
