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
end

return {
  "nvim-neotest/neotest",
  ft = { "python", "go" },
  keys = {
    {
      "<leader>tt",
      function()
        require("neotest").run.run()
      end,
    },
    {
      "<leader>tae",
      function()
        require("neotest").run.run(vim.fn.expand "%")
      end,
    },
    {
      "<leader>tx",
      function()
        require("neotest").run.stop()
      end,
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open()
      end,
    },
  },
  config = config,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/neotest-go",
    "sidlatau/neotest-dart",
  },
}
