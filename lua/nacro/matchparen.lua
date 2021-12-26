local M = {}

local matchparen = require "matchparen"

function M.setup()
  vim.g.loaded_matchparen = 1

  matchparen.setup {}
end

return M
