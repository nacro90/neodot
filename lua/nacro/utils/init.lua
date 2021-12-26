local utils = {}

local vim = vim
local fn = vim.fn

function utils.get_os()
  local has = fn.has
  if has "macunix" then
    return "mac"
  elseif has "unix" then
    return "linux"
  end
end

utils.map = require "nacro.utils.map"

return utils
