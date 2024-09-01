local function config()
  require("neotest").setup {
    adapters = {
      require "neotest-golang",
      require "neotest-dart",
    },
  }
end

return {
  "nvim-neotest/neotest",
  ft = { "python", "go", "dart" },
  keys = {
    {
      "<leader>tt",
      function()
        vim.cmd "write"
        require("neotest").run.run()
      end,
    },
    {
      "<leader>tae",
      function()
        vim.cmd "write"
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
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
    },
  },
  config = config,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/neotest-go",
    "fredrikaverpil/neotest-golang",
    "sidlatau/neotest-dart",
    "nvim-neotest/nvim-nio",
  },
}
