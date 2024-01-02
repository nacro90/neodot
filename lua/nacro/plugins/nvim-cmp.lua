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
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "zsh" },
      { name = "nvim_lua" },
      { name = "luasnip", max_item_count = 1 },
    }, {
      { name = "buffer" },
      { name = "path" },
    }, {
      { name = "emoji", options = { insert = true } },
    }),
    experimental = {
      ghost_text = true,
    },
    preselect = cmp.PreselectMode.Item,
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
        end
      end, {
        "i",
      }),
      ["<C-p>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()
        end
      end, { "i" }),
      ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-d>"] = cmp.mapping { c = cmp.mapping.complete() },
      ["<C-e>"] = cmp.mapping.abort(),
      ["<CR>"] = cmp.mapping.confirm { select = true },
    },
  }
  -- setup has a metatable that can be called and can be used as a table
  ---@diagnostic disable-next-line: undefined-field
  cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    completion = {
      autocomplete = false,
    },
    sources = cmp.config.sources({
      { name = "buffer" },
    }, {
      { name = "fuzzy_buffer" },
    }),
  })
  cmp.setup.cmdline("?", {
    mapping = cmp.mapping.preset.cmdline(),
    completion = {
      autocomplete = false,
    },
    sources = cmp.config.sources({
      { name = "buffer" },
    }, {
      { name = "fuzzy_buffer" },
    }),
  })
  ---@diagnostic disable-next-line: undefined-field
  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    completion = {
      autocomplete = false,
    },
    sources = cmp.config.sources({
      { name = "cmdline" },
    }, {
      { name = "fuzzy_path" },
    }),
  })
  cmp.setup.filetype("gitcommit", {
    sources = cmp.config.sources({
      { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = "buffer" },
    }),
  })
  cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, {
    sources = {
      { name = "dap" },
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
    { "tzachar/cmp-fuzzy-path", dependencies = { "tzachar/fuzzy.nvim" } },
    { "tzachar/cmp-fuzzy-buffer", dependencies = { "tzachar/fuzzy.nvim" } },
    {
      "tamago324/cmp-zsh",
      config = true,
      opts = {
        filetypes = { "deoledit", "zsh" },
      },
    },
    "rcarriga/cmp-dap",
  },
}
