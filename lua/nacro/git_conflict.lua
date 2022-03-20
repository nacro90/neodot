local M = {}

local git_conflict = require "git-conflict"

function M.setup()
  git_conflict.setup {
    disable_diagnostics = true,
  }
end

return M
