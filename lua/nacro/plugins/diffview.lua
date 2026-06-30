return {
  "sindrets/diffview.nvim",
  cmd = {
    "DiffviewOpen",
    "DiffviewFileHistory",
    "DiffviewClose",
    "DiffviewToggleFiles",
    "DiffviewFocusFiles",
  },
  keys = {
    { "<leader>gd", "<Cmd>DiffviewOpen<CR>", desc = "Diffview open" },
    { "<leader>gD", "<Cmd>DiffviewClose<CR>", desc = "Diffview close" },
    { "<leader>gh", "<Cmd>DiffviewFileHistory %<CR>", desc = "File history (current)" },
    { "<leader>gH", "<Cmd>DiffviewFileHistory<CR>", desc = "File history (all)" },
  },
  opts = {
    diff_binaries = false,
    enhanced_diff_hl = true, -- Better diff highlighting
    use_icons = true,
    show_help_hints = true,

    -- File panel settings
    file_panel = {
      listing_style = "tree",
      tree_options = {
        flatten_dirs = true,
        folder_statuses = "only_folded",
      },
      win_config = {
        position = "left",
        width = 35,
      },
    },

    -- File history panel
    file_history_panel = {
      log_options = {
        git = {
          single_file = {
            diff_merges = "combined",
            follow = true, -- Follow renames
          },
          multi_file = {
            diff_merges = "first-parent",
          },
        },
      },
      win_config = {
        position = "bottom",
        height = 16,
      },
    },

    -- Merge tool configuration (3-way merge)
    view = {
      default = {
        layout = "diff2_horizontal",
      },
      merge_tool = {
        -- 4-panel layout: LOCAL | BASE | REMOTE on top, MERGED on bottom
        layout = "diff3_mixed",
        disable_diagnostics = true,
        winbar_info = true, -- Show which version each panel is
      },
      file_history = {
        layout = "diff2_horizontal",
      },
    },

    hooks = {
      diff_buf_read = function(bufnr)
        -- Enable syntax highlighting in diff buffers (Treesitter + diff bg)
        vim.opt_local.syntax = "on"
        -- Disable folding for cleaner view
        vim.opt_local.foldenable = false
        -- Ensure treesitter highlighting is active
        local ok, ts_highlight = pcall(require, "nvim-treesitter.highlight")
        if ok then
          pcall(ts_highlight.attach, bufnr)
        end
      end,
    },

    keymaps = {
      disable_defaults = false,
      view = {
        -- Conflict resolution keymaps (the main addition!)
        { "n", "<leader>co", "<Cmd>DiffviewConflictPick('ours')<CR>", { desc = "Choose OURS (local)" } },
        { "n", "<leader>ct", "<Cmd>DiffviewConflictPick('theirs')<CR>", { desc = "Choose THEIRS (remote)" } },
        { "n", "<leader>cb", "<Cmd>DiffviewConflictPick('both')<CR>", { desc = "Choose BOTH" } },
        { "n", "<leader>cB", "<Cmd>DiffviewConflictPick('base')<CR>", { desc = "Choose BASE" } },
        { "n", "<leader>cn", "<Cmd>DiffviewConflictPick('none')<CR>", { desc = "Choose NONE (delete)" } },
        -- Navigation between conflicts
        { "n", "]x", "<Cmd>DiffviewNextConflict<CR>", { desc = "Next conflict" } },
        { "n", "[x", "<Cmd>DiffviewPrevConflict<CR>", { desc = "Previous conflict" } },
        -- Toggle file panel
        { "n", "<leader>e", "<Cmd>DiffviewToggleFiles<CR>", { desc = "Toggle file panel" } },
        -- Refresh
        { "n", "R", "<Cmd>DiffviewRefresh<CR>", { desc = "Refresh" } },
      },
      diff3 = {
        -- In 3-way diff, additional options
        { "n", "<leader>c1", "<Cmd>diffget LOCAL<CR>", { desc = "Get from LOCAL" } },
        { "n", "<leader>c2", "<Cmd>diffget BASE<CR>", { desc = "Get from BASE" } },
        { "n", "<leader>c3", "<Cmd>diffget REMOTE<CR>", { desc = "Get from REMOTE" } },
      },
      file_panel = {
        { "n", "j", "<Cmd>DiffviewNext<CR>", { desc = "Next file" } },
        { "n", "k", "<Cmd>DiffviewPrev<CR>", { desc = "Previous file" } },
        { "n", "<CR>", "<Cmd>DiffviewOpen<CR>", { desc = "Open file" } },
        { "n", "s", "<Cmd>DiffviewToggleStage<CR>", { desc = "Stage/unstage" } },
        { "n", "S", "<Cmd>DiffviewStageAll<CR>", { desc = "Stage all" } },
        { "n", "U", "<Cmd>DiffviewUnstageAll<CR>", { desc = "Unstage all" } },
        { "n", "X", "<Cmd>DiffviewRestore<CR>", { desc = "Restore (checkout)" } },
        { "n", "q", "<Cmd>DiffviewClose<CR>", { desc = "Close diffview" } },
      },
      file_history_panel = {
        { "n", "q", "<Cmd>DiffviewClose<CR>", { desc = "Close diffview" } },
      },
    },
  },
}
