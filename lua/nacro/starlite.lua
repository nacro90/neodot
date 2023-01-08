local M = {}

local starlite = require "starlite"

function M.setup()
  vim.keymap.set("n", "*", starlite.star)
  vim.keymap.set("n", "g*", starlite.g_star)
  vim.keymap.set("n", "#", starlite.hash)
  vim.keymap.set("n", "g#", starlite.g_hash)
end

return M
