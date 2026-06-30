return {
  "saghen/blink.cmp",
  enabled = false,
  version = "1.*",
  event = { "InsertEnter", "CmdlineEnter" },
  dependencies = {
    -- NOTE: For nvim-cmp sources compatibility, uncomment blink.compat:
    -- { "saghen/blink.compat", version = "2.*", lazy = true },
  },

  config = function(_, opts)
    require("blink.cmp").setup(opts)

    -- Trigger completion immediately when entering cmdline
    vim.api.nvim_create_autocmd("CmdlineEnter", {
      pattern = ":",
      callback = function()
        vim.schedule(function()
          local ok, cmp = pcall(require, "blink.cmp")
          if ok then
            cmp.show()
          end
        end)
      end,
    })
  end,

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- Snippet engine: use blink.cmp's built-in engine (default)
    -- snippets = { preset = "luasnip" }, -- Uncomment if you want LuaSnip

    -- Appearance settings
    appearance = {
      use_nvim_cmp_as_default = false,
      nerd_font_variant = "mono",
    },

    -- Completion behavior
    completion = {
      -- VS Code style: first item selected, Enter to confirm
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },

      -- Ghost text preview
      ghost_text = { enabled = true },

      -- Documentation window
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
        window = {
          border = "none",
        },
      },

      -- Menu appearance
      menu = {
        border = "none",
        draw = {
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
          },
        },
      },
    },

    -- Signature help
    signature = {
      enabled = true,
      window = { border = "rounded" },
    },

    -- Keymap configuration (matching nvim-cmp behavior)
    keymap = {
      preset = "none", -- Start fresh

      -- Show completion manually
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },

      -- Navigation (C-n/C-p for selection, show if not visible)
      ["<C-n>"] = { "show", "select_next", "snippet_forward", "fallback" },
      ["<C-p>"] = { "show", "select_prev", "snippet_backward", "fallback" },

      -- Scroll documentation (was C-u/C-d in nvim-cmp)
      ["<C-u>"] = { "scroll_documentation_up", "fallback" },
      ["<C-d>"] = { "scroll_documentation_down", "fallback" },

      -- Close/cancel
      ["<C-e>"] = { "hide", "fallback" },

      -- Accept completion (CR with select=true behavior)
      ["<CR>"] = { "accept", "fallback" },

      -- Signature help (was C-q in nvim-cmp lsp.lua)
      ["<C-q>"] = { "show_signature", "hide_signature", "fallback" },
    },

    -- Sources configuration
    sources = {
      -- Default sources (order matters for priority)
      -- Built-in: lsp, buffer, snippets, path
      default = { "lsp", "snippets", "path", "buffer" },

      -- Per-filetype source configuration
      per_filetype = {
        -- Disable for OverseerForm
        OverseerForm = {},

        -- Markdown: no auto sources (was autocomplete = false)
        markdown = { "buffer" },

        -- Git commit: git source + buffer
        -- NOTE: cmp-git source needs blink.compat, comment for now
        -- gitcommit = { inherit_defaults = false, "git", "buffer" },
        gitcommit = { "buffer" },

        -- DAP REPL: dap source
        -- NOTE: cmp-dap needs blink.compat, comment for now
        -- ["dap-repl"] = { "dap" },
        -- dapui_watches = { "dap" },
        -- dapui_hover = { "dap" },

        -- SQL: dadbod completion
        -- NOTE: Has native blink support via vim_dadbod_completion.blink
        sql = { inherit_defaults = true, "dadbod" },
        mysql = { inherit_defaults = true, "dadbod" },
        plsql = { inherit_defaults = true, "dadbod" },

        -- Todo filetype: buffer with special handling
        todo = { "buffer", "snippets" },
      },

      -- Provider configurations
      providers = {
        -- Custom cmdline history source
        cmdline_history = {
          name = "History",
          module = "nacro.blink.cmdline_history",
          score_offset = 10, -- Prioritize history items
        },

        -- Override built-in cmdline source icon
        cmdline = {
          transform_items = function(_, items)
            for _, item in ipairs(items) do
              item.kind_icon = ""
              item.kind_name = "Command"
            end
            return items
          end,
        },

        -- Dadbod completion (native blink support)
        dadbod = {
          name = "Dadbod",
          module = "vim_dadbod_completion.blink",
        },

        -- NOTE: For nvim-cmp sources via blink.compat, add providers like:
        -- emoji = {
        --   name = "emoji",
        --   module = "blink.compat.source",
        --   opts = { insert = true },
        -- },
        -- zsh = {
        --   name = "zsh",
        --   module = "blink.compat.source",
        -- },
        -- fuzzy_path = {
        --   name = "fuzzy_path",
        --   module = "blink.compat.source",
        -- },
        -- git = {
        --   name = "git",
        --   module = "blink.compat.source",
        -- },
        -- dap = {
        --   name = "dap",
        --   module = "blink.compat.source",
        -- },
      },
    },

    -- Cmdline configuration
    cmdline = {
      enabled = true,
      keymap = {
        preset = "cmdline",
        -- Custom cmdline keymaps
        ["<C-n>"] = { "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-e>"] = { "cancel", "fallback" },
        ["<CR>"] = { "accept_and_enter", "fallback" },
        -- Delete history item with C-x
        ["<C-x>"] = {
          function(cmp)
            local item = cmp.get_selected_item()
            if item and item.source_id == "cmdline_history" then
              local cmd = item.label
              local escaped = vim.pesc(cmd)
              vim.fn.histdel(":", "^" .. escaped .. "$")
              cmp.cancel()
              vim.schedule(function()
                cmp.show()
              end)
              return true
            end
            return false
          end,
          "fallback",
        },
      },
      sources = function()
        local type = vim.fn.getcmdtype()
        -- Search forward and backward: buffer only
        if type == "/" or type == "?" then
          return { "buffer" }
        end
        -- Commands: history first, then cmdline
        if type == ":" or type == "@" then
          return { "cmdline_history", "cmdline" }
        end
        return {}
      end,
      completion = {
        menu = {
          auto_show = true,
          direction_priority = { "n", "s" }, -- Open upward, most recent near cursor
        },
        list = {
          selection = {
            preselect = true,
            auto_insert = false,
          },
        },
        ghost_text = { enabled = true },
      },
    },
  },
}
