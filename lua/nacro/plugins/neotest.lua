local function config()
  require("neotest").setup {
    adapters = {
      require("neotest-golang")({
        runner = "gotestsum",
        gotestsum_args = { "--format=testname" },
        go_test_args = { "-v", "-count=1" },
      }),
      require("neotest-dart")({}),
      require("neotest-plenary"),
    },
    output = {
      enabled = true,
      open_on_run = "short",
    },
    output_panel = {
      enabled = true,
      open = "botright split | resize 15",
    },
    status = {
      enabled = true,
      virtual_text = true,
      signs = true,
    },
    icons = {
      passed = "",
      failed = "",
      running = "",
      skipped = "",
      unknown = "",
    },
    summary = {
      animated = true,
      mappings = {
        expand = { "<CR>", "<2-LeftMouse>" },
        expand_all = "e",
        output = "o",
        short = "O",
        attach = "a",
        jumpto = "i",
        stop = "u",
        run = "r",
        mark = "m",
        clear_marked = "M",
        target = "t",
      },
    },
  }
end

return {
  "nvim-neotest/neotest",
  ft = { "python", "go", "dart", "lua" },
  keys = {
    {
      "<leader>tt",
      function()
        vim.cmd "write"
        require("neotest").run.run()
      end,
      desc = "Test nearest",
    },
    {
      "<leader>tf",
      function()
        vim.cmd "write"
        require("neotest").run.run(vim.fn.expand "%")
      end,
      desc = "Test file",
    },
    {
      "<leader>ta",
      function()
        require("neotest").run.run(vim.uv.cwd())
      end,
      desc = "Test all (project)",
    },
    {
      "<leader>tl",
      function()
        require("neotest").run.run_last()
      end,
      desc = "Test last",
    },
    {
      "<leader>tx",
      function()
        require("neotest").run.stop()
      end,
      desc = "Test stop",
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open { enter = true, auto_close = true }
      end,
      desc = "Test output",
    },
    {
      "<leader>tp",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Test panel",
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Test summary",
    },
    {
      "[t",
      function()
        require("neotest").jump.prev { status = "failed" }
      end,
      desc = "Prev failed test",
    },
    {
      "]t",
      function()
        require("neotest").jump.next { status = "failed" }
      end,
      desc = "Next failed test",
    },
  },
  config = config,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-neotest/nvim-nio",
    -- Adapters
    "fredrikaverpil/neotest-golang",
    "sidlatau/neotest-dart",
    "nvim-neotest/neotest-plenary",
  },
  build = function()
    if vim.fn.executable "go" == 1 then
      vim.fn.system { "go", "install", "gotest.tools/gotestsum@latest" }
    end
  end,
}
