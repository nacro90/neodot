local M = {}

local neotest = require("neotest")

function M.setup()
  neotest.setup {
    adapters = {
      require("neotest-go"),
    }
  }
end

return M
