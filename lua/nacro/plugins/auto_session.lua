return {
  "rmagatti/auto-session",
  opts = {
    log_level = "error",
    auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/" },
  },
  config = function(opts)
    require("auto-session").setup(opts)
    vim.o.sessionoptions =
      "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
  end,
  enabled = false,
}
