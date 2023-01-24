local function create_snippet_config()
  local exists, luasnip = pcall(require, "luasnip")
  local snip_conf
  if exists then
    snip_conf = {
      expand = function(args)
        luasnip.lsp_expand(args.body)
      end,
    }
  end
  return snip_conf
end

local function config()
  local cmp = require "cmp"
  cmp.setup {
    snippet = create_snippet_config(),
    sources = {
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "luasnip", max_item_count = 1 },
      { name = "path" },
      { name = "buffer" },
      { name = "emoji", options = { insert = true } },
      { name = "neorg" },
    },
    experimental = {
      ghost_text = true,
    },
    preselect = cmp.PreselectMode.None,
    formatting = {
      format = require("lspkind").cmp_format {
        with_text = false,
        maxwidth = 50,
      },
    },
    mapping = {
      ["<C-n>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_next_item()
        else
          cmp.complete()
        end
      end, {
        "i",
      }),
      ["<C-p>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        else
          cmp.complete()
        end
      end),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-d>"] = cmp.mapping { c = cmp.mapping.complete() },
      ["<C-e>"] = cmp.mapping { c = cmp.mapping.abort() },
      ["<CR>"] = cmp.mapping.confirm { select = true },
    },
  }
  -- setup has a metatable that can be called and can be used as a table
  ---@diagnostic disable-next-line: undefined-field
  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })
  cmp.setup.cmdline("?", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = "buffer" },
    },
  })
  ---@diagnostic disable-next-line: undefined-field
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    completion = {
      autocomplete = false,
    },
    sources = {
      { name = "cmdline" },
      { name = "path" },
    },
  })
end

return {
  "hrsh7th/nvim-cmp",
  event = { "CmdlineEnter", "InsertEnter" },
  config = config,
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-emoji",
    "onsails/lspkind-nvim",
    "hrsh7th/cmp-cmdline",
    "dmitmel/cmp-cmdline-history",
  },
}
