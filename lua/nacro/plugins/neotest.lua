local function config()
  local neotest = require "neotest"
  neotest.setup {
    diagnostic = { enabled = false },
    adapters = {
      require "neotest-go",
      require "neotest-dart" {
        command = vim.env.HOME .. "/.local/lib/flutter/bin/flutter",
      },
    },
  }
  vim.keymap.set("n", "<leader>tt", neotest.run.run)
  vim.keymap.set("n", "<leader>tae", function()
    neotest.run.run(vim.fn.expand "%")
  end)
  vim.keymap.set("n", "<leader>tx", neotest.run.stop)
  vim.keymap.set("n", "<leader>to", neotest.output.open)
end

return {
  "nvim-neotest/neotest",
  ft = { "python", "go" },
  config = config,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/neotest-go",
    "sidlatau/neotest-dart",
  },
}
