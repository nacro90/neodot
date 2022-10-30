local M = {}

local colorizer = require "colorizer"

function M.setup()
  colorizer.setup {
    telekasten = {
      names = false
    }
  }
end

return M
