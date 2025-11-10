return {
  "rmagatti/auto-session",
    lazy = false,
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    -- log_level = "error",
    -- auto_session_enable_last_session = false,
    -- auto_save_enabled = false,
    -- auto_session_enabled = false,
    auto_session_suppress_dirs = { "/home/nacro90", "~/", "~/Projects", "~/Downloads", "/" },
    -- auto_restore_enabled = false,
    -- auto_session_enable_last_session = vim.loop.cwd() == vim.loop.os_homedir(),
  },
  enabled = true,
}
