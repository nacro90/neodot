local M = {}

local neogit = require "neogit"

local function get_cwd()
  return vim.fn.expand "%:h"
end

local function setup_keymaps()
  vim.keymap.set("n", "<leader>g", function()
    neogit.open { kind = "split" }
  end)
  vim.keymap.set("n", "<leader>G", function()
    neogit.open { kind = "commit" }
  end)
end

function M.setup()
  setup_keymaps()

  neogit.setup {
    integrations = {
      diffview = true,
    },
    disable_context_highlighting = true,
    disable_commit_confirmation = true,
    signs = {
      section = { "▪", "-" },
      item = { "▪", "-" },
      hunk = { "▪", "-" },
    },
  }
end

return M
