return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  opts = {
    input = {
      -- Enable input UI
      enabled = true,
      -- Default prompt string
      default_prompt = "Input",
      -- Trim trailing `:` from prompt
      trim_prompt = true,
      -- Title position: "left", "center", "right"
      title_pos = "left",
      -- Start in insert mode
      start_in_insert = true,
      -- Border style
      border = "rounded",
      -- 'editor' or 'win' - relative to cursor
      relative = "cursor",
      -- Position above cursor so you can see what you're renaming
      row = -3,
      col = 0,
      -- Prefer width based on content
      prefer_width = 40,
      -- Min/max constraints
      min_width = 20,
      max_width = { 140, 0.9 },
      -- Window options
      win_options = {
        wrap = false,
        list = true,
        listchars = "precedes:…,extends:…",
        sidescrolloff = 0,
        -- Subtle background
        winblend = 10,
      },
      -- Keymaps in input mode
      mappings = {
        n = {
          ["<Esc>"] = "Close",
          ["<CR>"] = "Confirm",
        },
        i = {
          ["<C-c>"] = "Close",
          ["<CR>"] = "Confirm",
          ["<C-p>"] = "HistoryPrev",
          ["<C-n>"] = "HistoryNext",
          ["<Up>"] = "HistoryPrev",
          ["<Down>"] = "HistoryNext",
        },
      },
    },

    select = {
      -- Enable select UI
      enabled = true,
      -- Priority list of backends
      backend = { "telescope", "builtin", "nui" },
      -- Trim trailing `:` from prompt
      trim_prompt = true,

      -- Telescope options
      telescope = {
        layout_strategy = "cursor",
        layout_config = {
          width = 0.5,
          height = 0.4,
        },
      },

      -- Builtin selector (fallback)
      builtin = {
        show_numbers = true,
        border = "rounded",
        relative = "cursor",
        row = 0,
        col = 1,
        win_options = {
          cursorline = true,
          cursorlineopt = "both",
          winblend = 10,
        },
        -- Width based on content
        min_width = 20,
        max_width = { 80, 0.8 },
        min_height = 3,
        max_height = 0.8,
        -- Mappings
        mappings = {
          ["<Esc>"] = "Close",
          ["<C-c>"] = "Close",
          ["<CR>"] = "Confirm",
          ["j"] = "MoveDown",
          ["k"] = "MoveUp",
        },
      },

      -- Format item function for better display
      format_item_override = {
        -- Code actions get special formatting
        codeaction = function(action_tuple)
          local title = action_tuple[2].title:gsub("\r\n", "\\r\\n")
          local client_name = action_tuple[1]
          return string.format("%s [%s]", title, client_name)
        end,
      },

      -- Get specific config for certain kinds
      get_config = function(opts)
        -- Code actions use telescope with cursor layout
        if opts.kind == "codeaction" then
          return {
            backend = "telescope",
            telescope = {
              layout_strategy = "cursor",
              layout_config = {
                width = 0.6,
                height = 0.4,
              },
            },
          }
        end
      end,
    },
  },
}
