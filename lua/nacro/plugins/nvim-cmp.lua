local function on_demand_complete()
  require("cmp").complete {
    config = {
      sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "fuzzy_path" },
        { name = "buffer" },
        { name = "fuzzy_buffer" },
      },
    },
  }
end

local function config()
  local cmp = require "cmp"
  local luasnip = require "luasnip"

  -- Register custom cmdline_history source
  cmp.register_source("cmdline_history_ordered", require("nacro.cmp.cmdline_history").new())

  -- Make match highlights more visible
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { link = "Special" })
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { link = "Special" })

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
    }, {
      { name = "buffer" },
      { name = "fuzzy_path", keyword_length = 3 },
    }, {
      { name = "emoji", options = { insert = true } },
    }),
    experimental = {
      ghost_text = true,
    },
    preselect = cmp.PreselectMode.None,
    formatting = {
      fields = { "abbr", "kind" },
      format = require("lspkind").cmp_format {
        mode = "symbol",
        maxwidth = 50,
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
  for _, cmd in ipairs { "/", "?" } do
    cmp.setup.cmdline(cmd, {
      mapping = cmp.mapping.preset.cmdline(),
      completion = { autocomplete = false },
      sources = cmp.config.sources({
        { name = "buffer" },
      }, {
        { name = "fuzzy_buffer" },
      }),
    })
  end
  -- Trigger completion immediately when entering cmdline
  vim.api.nvim_create_autocmd("CmdlineEnter", {
    pattern = ":",
    callback = function()
      vim.schedule(function()
        cmp.complete()
      end)
    end,
  })

  ---@diagnostic disable-next-line: undefined-field
  cmp.setup.cmdline(":", {
    mapping = {
      ["<C-n>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_prev_item()  -- near_cursor mode: prev = visual down
        else
          cmp.complete()
        end
      end, { "c" }),
      ["<C-p>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_next_item()  -- near_cursor mode: next = visual up
        else
          cmp.complete()
        end
      end, { "c" }),
      ["<C-e>"] = { c = cmp.mapping.close() },
      ["<CR>"] = { c = cmp.mapping.confirm({ select = false }) },
      ["<Tab>"] = cmp.mapping(function()
        if cmp.visible() then
          cmp.select_next_item()
        else
          cmp.complete()
        end
      end, { "c" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        else
          fallback()
        end
      end, { "c" }),
      ["<C-x>"] = cmp.mapping(function()
        local entry = cmp.get_selected_entry()
        if entry and entry.source.name == "cmdline_history_ordered" then
          local escaped = vim.pesc(entry:get_word())
          vim.fn.histdel(":", "^:*" .. escaped .. "$")
          cmp.abort()
          vim.schedule(function()
            cmp.complete()
          end)
        end
      end, { "c" }),
    },
    completion = { autocomplete = { "TextChanged" }, keyword_length = 0 },
    sorting = {
      comparators = {
        cmp.config.compare.sort_text,
      },
    },
    view = { entries = { selection_order = "near_cursor" } },
    formatting = {
      fields = { "abbr", "kind" },
      format = function(entry, vim_item)
        if entry.source.name == "cmdline_history_ordered" then
          vim_item.kind = "󰋚"  -- history icon
        elseif entry.source.name == "cmdline" then
          vim_item.kind = "󰞷"  -- command icon
        else
          vim_item.kind = ""
        end
        return vim_item
      end,
    },
    sources = {
      { name = "cmdline_history_ordered", keyword_length = 0 },
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
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lua",
    "hrsh7th/cmp-emoji",
    "onsails/lspkind-nvim",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/cmp-path",
    "dmitmel/cmp-cmdline-history",
    "petertriho/cmp-git",
    { "tzachar/cmp-fuzzy-path", dependencies = { "tzachar/fuzzy.nvim" } },
    { "tzachar/cmp-fuzzy-buffer", dependencies = { "tzachar/fuzzy.nvim" } },
    { "tamago324/cmp-zsh", opts = { filetypes = { "deoledit", "zsh" } } },
    "rcarriga/cmp-dap",
    "kristijanhusak/vim-dadbod-completion",
  },
}

