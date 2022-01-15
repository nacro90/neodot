local completion = {}

local cmp = require "cmp"

local luasnip_exists, luasnip = pcall(require, 'luasnip')

local function create_lspkind_formetter()
  local exists, lspkind = pcall(require, "lspkind")

  if not exists then
    return function(...)
      return ...
    end
  end

  return lspkind.cmp_format { with_text = false, maxwidth = 50 }
end

function completion.setup()
  cmp.setup {
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    sources = {
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "luasnip" },
      { name = "path" },
      { name = "buffer", keyword_length = 5 },
      { name = "emoji", keyword_length = 3 },
      { name = "neorg" },
    },
    experimental = {
      ghost_text = false,
    },
    preselect = cmp.PreselectMode.Item,
    formatting = {
      format = create_lspkind_formetter(),
    },
    mapping = {
      ["<C-n>"] = cmp.mapping(function()
        if luasnip_exists and luasnip.choice_active() then
          luasnip.change_choice(1)
        elseif cmp.visible() then
          cmp.select_next_item()
        else
          cmp.complete()
        end
      end, { "i" }),
      ["<C-p>"] = cmp.mapping(function()
        if luasnip_exists and luasnip.choice_active() then
          luasnip.change_choice(-1)
        elseif cmp.visible() then
          cmp.select_next_item()
        else
          cmp.complete()
        end
      end, { "i" }),
      ["<C-d>"] = cmp.mapping(cmp.mapping.complete(), { "c" }),
      ["<C-e>"] = cmp.mapping(cmp.mapping.abort(), { "c" }),
      ["<CR>"] = cmp.mapping.confirm { select = true },
    },
  }

  local search_cmd_cmp_opts = {
    sources = {
      { name = "buffer" },
    },
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
  })
end

return completion
