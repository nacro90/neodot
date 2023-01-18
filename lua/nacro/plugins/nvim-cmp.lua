local function create_lspkind_formetter()
  local exists, lspkind = pcall(require, "lspkind")

  if not exists then
    return function(...)
      return ...
    end
  end

  return lspkind.cmp_format { with_text = false, maxwidth = 50 }
end

local function config()
  local cmp = require "cmp"

  local luasnip_exists, luasnip = pcall(require, "luasnip")
  local snip_conf
  if luasnip_exists then
    snip_conf = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    }
  end

  cmp.setup {
    snippet = snip_conf,
    sources = {
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "luasnip" },
      { name = "path" },
      { name = "buffer", keyword_length = 5 },
      -- { name = "digraphs", group_index = 2 },
      { name = "emoji", keyword_length = 3, options = { insert = true } },
      { name = "neorg" },
    },
    experimental = {
      ghost_text = true,
    },
    preselect = cmp.PreselectMode.Item,
    formatting = {
      format = create_lspkind_formetter(),
    },
    mapping = cmp.mapping.preset.insert {
      ["<C-n>"] = cmp.mapping(function()
        if luasnip_exists and luasnip.choice_active() then
          luasnip.change_choice(1)
        elseif cmp.visible() then
          cmp.select_next_item()
        else
          cmp.complete()
        end
      end, {
        "i",
      }),
      ["<C-p>"] = cmp.mapping(function()
        if luasnip_exists and luasnip.choice_active() then
          luasnip.change_choice(-1)
        elseif cmp.visible() then
          cmp.select_prev_item()
        else
          cmp.complete()
        end
      end, {
        "i",
      }),
      ["<C-d>"] = cmp.mapping(cmp.mapping.complete(), { "c" }),
      ["<C-e>"] = cmp.mapping(cmp.mapping.abort(), { "c" }),
      ["<CR>"] = cmp.mapping.confirm { select = true },
      -- ["<C-k>"] = cmp.mapping.confirm { select = true },
    },
  }

  local search_cmd_cmp_opts = {
    sources = {
      { name = "buffer" },
    },
    mapping = cmp.mapping.preset.cmdline(),
  }
  -- setup has a metatable that can be called and can be used as a table
  ---@diagnostic disable-next-line: undefined-field
  cmp.setup.cmdline("/", search_cmd_cmp_opts)
  cmp.setup.cmdline("?", search_cmd_cmp_opts)

  ---@diagnostic disable-next-line: undefined-field
  cmp.setup.cmdline(":", {
    sources = {
      { name = "cmdline" },
      { name = "path" },
      { name = "cmdline_history" },
    },
    mapping = cmp.mapping.preset.cmdline(),
  })
end

return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
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
