local completion = {}

local cmp = require "cmp"
local lspkind = require "lspkind"

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
      format = lspkind.cmp_format { with_text = false, maxwidth = 50 },
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
