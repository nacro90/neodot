local M = {}

local flutter_tools = require "flutter-tools"
local common = require "nacro.lsp.common"

function M.setup()
  flutter_tools.setup {
    ui = {
      notification_style = "native",
    },
    decorations = {
      statusline = {
        device = true,
      },
    },
    lsp = {
      on_attach = common.on_attach,
    },
  }
end

return M
