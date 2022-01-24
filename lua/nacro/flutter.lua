local M = {}

local flutter_tools = require "flutter-tools"
local common = require "nacro.lsp.common"

function M.setup()
  flutter_tools.setup {
    lsp = {
      on_attach = common.on_attach,
    },
  }
end

return M
