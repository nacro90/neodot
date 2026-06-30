return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
  },
  opts = {
    -- Git command console settings
    console_timeout = 5000, -- Console visible for 5 seconds after command
    auto_show_console = true, -- Always show console output
    auto_close_console = false, -- Don't auto-close, let timeout handle it

    -- Status buffer appearance
    graph_style = "unicode",
    kind = "tab", -- Open in new tab (your preference)

    -- Show recent commits in status buffer
    status = {
      recent_commit_count = 15, -- Show last 15 commits
      show_head_commit_hash = true,
    },

    -- Auto-refresh when files change
    auto_refresh = true,
    filewatcher = {
      enabled = true,
      interval = 1000, -- Check every second
    },

    -- Commit settings
    commit_editor = {
      kind = "split",
      spell_check = true, -- Spell check for commit messages
    },
    commit_view = {
      kind = "vsplit",
      verify_commit = false, -- Don't verify on view
    },

    -- Popup settings - frequently used options more accessible
    commit_popup = {
      kind = "split",
    },

    -- Signs for sections
    signs = {
      hunk = { "", "" },
      item = { "▸", "▾" },
      section = { "▸", "▾" },
    },

    -- Integrations
    integrations = {
      diffview = true,
      telescope = true,
    },

    -- Disable hints if you're experienced
    disable_hint = false,
    disable_insert_on_commit = false, -- Start in insert mode for commit msg

    -- Sections to show in status buffer
    sections = {
      sequencer = {
        folded = false,
        hidden = false,
      },
      untracked = {
        folded = false,
        hidden = false,
      },
      unstaged = {
        folded = false,
        hidden = false,
      },
      staged = {
        folded = false,
        hidden = false,
      },
      stashes = {
        folded = false, -- Stashes visible since you use it heavily
        hidden = false,
      },
      unpulled_upstream = {
        folded = false,
        hidden = false,
      },
      unmerged_upstream = {
        folded = false,
        hidden = false,
      },
      unpulled_pushRemote = {
        folded = true,
        hidden = false,
      },
      unmerged_pushRemote = {
        folded = true,
        hidden = false,
      },
      recent = {
        folded = false, -- Recent commits visible
        hidden = false,
      },
      rebase = {
        folded = false, -- Rebase section visible since you use it frequently
        hidden = false,
      },
    },

  },
  keys = {
    { "<leader>G", "<Cmd>Neogit<CR>", desc = "Neogit status" },
    { "<leader>gc", "<Cmd>Neogit commit<CR>", desc = "Neogit commit" },
    { "<leader>gp", "<Cmd>Neogit push<CR>", desc = "Neogit push" },
    { "<leader>gP", "<Cmd>Neogit pull<CR>", desc = "Neogit pull" },
    { "<leader>gl", "<Cmd>Neogit log<CR>", desc = "Neogit log" },
    { "<leader>gZ", "<Cmd>Neogit stash<CR>", desc = "Neogit stash" },
    { "<leader>gb", "<Cmd>Neogit branch<CR>", desc = "Neogit branch" },
    { "<leader>gr", "<Cmd>Neogit rebase<CR>", desc = "Neogit rebase" },
  },
  cmd = "Neogit",
}


