local M = {}

local neotest = require "neotest"

local function setup_neotest()
  neotest.setup {
    diagnostic = { enabled = false },
    adapters = {
      require "neotest-go",
      require "neotest-dart" {
        command = vim.env.HOME .. "/.local/lib/flutter/bin/flutter",
      },
    },
  }
end

local function setup_keymaps()
  vim.keymap.set("n", "<leader>tt", neotest.run.run)
  vim.keymap.set("n", "<leader>tae", function()
    neotest.run.run(vim.fn.expand "%")
  end)
  vim.keymap.set("n", "<leader>tx", neotest.run.stop)
  vim.keymap.set("n", "<leader>to", neotest.output.open)
end

function M.setup()
  setup_neotest()
  setup_keymaps()
end

return M
