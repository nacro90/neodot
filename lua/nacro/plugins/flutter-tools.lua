return {
  "akinsho/flutter-tools.nvim",
  lazy = false,
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = true,
  opts = {
    lsp = {
      on_attach = require("nacro.plugins.lspconfig").on_attach,
    },
  },
  keys = {
    {
      "<leader>FR",
      function()
        vim.cmd "FlutterRestart"
      end,
    },
    {
      "<leader>FS",
      function()
        vim.cmd "FlutterRun"
      end,
    },
    {
      "<leader>FQ",
      function()
        vim.cmd "FlutterQuit"
      end,
    },
  },
}
