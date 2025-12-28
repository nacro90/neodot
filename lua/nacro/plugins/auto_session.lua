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

    -- Use git branch in session name (separate sessions per branch)
    git_use_branch_name = true,

    -- Close these buffer types before saving (cleaner sessions)
    close_filetypes_on_save = {
      "neo-tree",
      "toggleterm",
      "dapui_scopes",
      "dapui_breakpoints",
      "dapui_stacks",
      "dapui_watches",
      "dap-repl",
    },

    -- Better session options
    session_lens = {
      load_on_setup = true,
      previewer = false,
    },
  },
}
