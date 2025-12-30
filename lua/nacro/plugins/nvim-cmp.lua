local function on_demand_complete()
  require("cmp").complete {
    config = {
      sources = {
        { name = "codeium" },
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
        { name = "buffer" },
        { name = "fuzzy_buffer" },
      },
    },
  }
end

local function config()
  local cmp = require "cmp"
  local luasnip = require "luasnip"

  vim.keymap.set({ "i", "s" }, "<C-n>", function()
    if cmp.visible() then
      cmp.select_next_item()
    elseif luasnip.locally_jumpable(1) then
      luasnip.jump(1)
    else
      on_demand_complete()
    end
  end, { silent = true })
  vim.keymap.set({ "i", "s" }, "<C-p>", function()
    if cmp.visible() then
      cmp.select_prev_item()
    elseif luasnip.locally_jumpable(-1) then
      luasnip.jump(-1)
    else
      on_demand_complete()
    end
  end, { silent = true })

  cmp.setup {
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    window = {
      documentation = {
        winhighlight = "Normal:Pmenu,FloatBorder:Pmenu,Search:None",
      },
    },
    sources = cmp.config.sources({
      { name = "nvim_lsp" },
      { name = "zsh" },
      { name = "nvim_lua" },
      { name = "luasnip" },
      {
        per_filetype = {
          codecompanion = { "codecompanion" },
        },
      },
    }, {
      { name = "buffer" },
      { name = "path" },
    }, {
      { name = "emoji", options = { insert = true } },
    }),
    experimental = {
      ghost_text = true,
    },
    preselect = cmp.PreselectMode.None,
    formatting = {
      format = require("lspkind").cmp_format {
        mode = "symbol",
        maxwidth = 50,
        symbol_map = { Codeium = "" },
      },
      expandable_indicator = true,
    },
    mapping = {
      ["<C-u>"] = cmp.mapping(function(fallback)
        if cmp.visible_docs() then
          cmp.scroll_docs(-4)
        else
          fallback()
        end
      end, { "i" }),
      ["<C-d>"] = cmp.mapping(function(fallback)
        if cmp.visible_docs() then
          cmp.scroll_docs(4)
        else
          fallback()
        end
      end, { "i" }),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm { select = true },
      ["<C-x>"] = cmp.mapping(
        cmp.mapping.complete_common_string {
          config = {
            sources = cmp.config.sources {
              { name = "nvim_lsp" },
            },
          },
        },
        { "i" }
      ),
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
    sources = cmp.config.sources {
      { name = "cmdline" },
    },
  })
  cmp.setup.filetype("OverseerForm", {
    enabled = false,
  })
  cmp.setup.filetype("todo", {
    sources = cmp.config.sources({
      {
        name = "buffer",
        trigger_characters = { "@", "+" },
        option = { keyword_pattern = [=[[@+]\w\+]=] },
      },
    }, {
      { name = "luasnip" },
    }),
  })
  cmp.setup.filetype("markdown", {
    completion = {
      autocomplete = false,
    },
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
  cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
    sources = {
      { name = "vim-dadbod-completion" },
    },
  })
end

return {
  "hrsh7th/nvim-cmp",
  event = { "CmdlineEnter", "InsertEnter" },
  config = config,
  dependencies = {
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lua",
    {
      "Exafunction/codeium.nvim",
      dependencies = {
        "nvim-lua/plenary.nvim",
        commit = "62d1e2e5691865586187bd6aa890e43b85c00518",
      },
      cmd = "Codeium",
      opts = {},
    },
    "hrsh7th/cmp-emoji",
    "onsails/lspkind-nvim",
    "hrsh7th/cmp-cmdline",
    "dmitmel/cmp-cmdline-history",
    { "tzachar/cmp-fuzzy-path",   dependencies = { "tzachar/fuzzy.nvim" } },
    { "tzachar/cmp-fuzzy-buffer", dependencies = { "tzachar/fuzzy.nvim" } },
    {
      "tamago324/cmp-zsh",
      opts = { filetypes = { "deoledit", "zsh" } },
    },
    "rcarriga/cmp-dap",
    "kristijanhusak/vim-dadbod-completion",
    {
      "tzachar/cmp-ai",
      enabled = false,
      dependencies = "nvim-lua/plenary.nvim",
      config = function()
        require("cmp_ai.config"):setup {
          max_lines = 100,
          provider = "Ollama",
          notify = true,
          notify_callback = function(msg)
            vim.notify(msg)
          end,
          run_on_every_keystroke = false,
          ignored_file_types = {
            -- default is not to ignore
            -- uncomment to ignore in lua:
            -- lua = true
          },
        }
      end,
    },
  },
}

