return {
  "rmagatti/auto-session",
  opts = {
    log_level = "error",
    auto_save_enabled = true,
    auto_session_suppress_dirs = { "home/nacro90", "~/", "~/Projects", "~/Downloads", "/" },
    cwd_change_handling = {
      restore_upcoming_session = true,
    },
    -- auto_session_enable_last_session = vim.loop.cwd() == vim.loop.os_homedir(),
  },
  config = function(opts)
    require("auto-session").setup(opts)
  end,
  enabled = true,
}
