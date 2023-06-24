local saferequire = require("nacro.module").saferequire

local function config()
  local autopairs = require "nvim-autopairs"
  local cmp_autopairs = require "nvim-autopairs.completion.cmp"

  autopairs.setup {
    enable_move_right = false,
    disable_in_macro = true,
  }
  autopairs.add_rules(require "nvim-autopairs.rules.endwise-lua")

  saferequire("cmp", function(cmp)
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end)
end

return {
  "windwp/nvim-autopairs",
  config = config,
  event = "InsertEnter",
}
