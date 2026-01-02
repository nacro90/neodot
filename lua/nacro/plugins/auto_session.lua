return {
  "rmagatti/auto-session",
  lazy = false,
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    -- Automatically save session on exit
    auto_save = true,
    -- Automatically restore session when entering a directory
    auto_restore = true,
    -- Create new sessions for directories that don't have one
    auto_create = true,

    -- KEY: Handle directory changes (zoxide integration)
    -- When you :cd or use zoxide, this saves current session and restores the new one
    cwd_change_handling = true,

    -- Directories where sessions should NOT be created/restored
    suppressed_dirs = {
      "/",
      "~/",
      "/home/nacro90",
      "~/Projects",
      "~/Downloads",
      "/tmp",
    },

    -- Don't use git branch in session name
    -- Same project = same session across all branches (IDE-like behavior)
    git_use_branch_name = false,

    -- Close these buffer types before saving (cleaner sessions)
    close_filetypes_on_save = {
      "neo-tree",
      "toggleterm",
      "dapui_scopes",
      "dapui_breakpoints",
      "dapui_stacks",
      "dapui_watches",
      "dap-repl",
      "snacks_terminal", -- ClaudeCode uses snacks.nvim terminal
    },

    -- Close Claude Code terminal buffers before saving
    -- (they are identified by buffer name containing "claude", not filetype)
    pre_save_cmds = {
      function()
        for _, buf in ipairs(vim.api.nvim_list_bufs()) do
          if vim.api.nvim_buf_is_valid(buf) and vim.bo[buf].buftype == "terminal" then
            local buf_name = vim.api.nvim_buf_get_name(buf)
            if buf_name:match("claude") then
              vim.api.nvim_buf_delete(buf, { force = true })
            end
          end
        end
      end,
    },

    -- Reload Arrow bookmarks after session restore
    post_restore_cmds = {
      function()
        local ok, arrow = pcall(require, "arrow.persist")
        if ok then
          arrow.load_cache_file()
        end
      end,
    },

    -- Better session options
    session_lens = {
      load_on_setup = true,
      previewer = false,
    },
  },
}
