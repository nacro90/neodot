local test = {}

local map = require "nacro.utils.map"
local nnoremap = map.nnoremap

local fn = vim.fn

function test.switch_to_test_go()
  local filename = fn.expand "%:t"
  if not filename:find "test.go$" then
  end
  local parent = fn.expand "%:h"
end

function test.setup()
  nnoremap("<leader>tn", "<Cmd>TestNearest<CR>")
  nnoremap("<leader>tt", "<Cmd>TestSuite<CR>")
end

return test
