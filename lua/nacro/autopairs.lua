local M = {}

local autopairs = require "nvim-autopairs"
local cmp_autopairs = require "nvim-autopairs.completion.cmp"

function M.setup()
  autopairs.setup {
    enable_move_right = false,
    disable_in_macro = true,
  }

  autopairs.add_rules(require "nvim-autopairs.rules.endwise-lua")

  local exists, cmp = pcall(require, "cmp")
  if exists then
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })
  end
end

M.setup()


return M
