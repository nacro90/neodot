local M = {}

function M.bootstrap()
  local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
  if not vim.loop.fs_stat(lazypath) then
    vim.fn.system {
      "git",
      "clone",
      "--filter=blob:none",
      "https://github.com/folke/lazy.nvim.git",
      "--branch=stable", -- latest stable release
      lazypath,
    }
  end
  vim.opt.rtp:prepend(lazypath)
end

function M.setup()
  local lazy = require "lazy"
  lazy.setup("nacro.plugins", {
    dev = {
      path = "~/Projects/plugins",
    },
    change_detection = {
      notify = false,
    },
    rtp = {
      disabled_plugins = {
        "gzip",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  })
end

return M
