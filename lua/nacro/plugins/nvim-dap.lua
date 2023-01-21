local function setup_signs()
  vim.fn.sign_define("DapBreakpoint", {
    text = "⬤",
    texthl = "ErrorMsg",
    linehl = "DiffDelete",
    numhl = "DiffDelete",
  })
  vim.fn.sign_define("DapBreakpointRejected", {
    text = "∅",
    texthl = "NonText",
    linehl = "",
    numhl = "",
  })
  vim.fn.sign_define("DapStopped", {
    text = "",
    texthl = "Constant",
    linehl = "Visual",
    numhl = "Visual",
  })
end

local function dapper(func)
  return function()
    require("dap")[func]()
  end
end

return {
  "mfussenegger/nvim-dap",
  keys = {
    { "<leader>db", dapper "toggle_breakpoint", { silent = true } },
    { "<leader>dd", dapper "continue", { silent = true } },
    { "<leader>dn", dapper "step_over", { silent = true } },
    { "<leader>di", dapper "step_into", { silent = true } },
    { "<leader>do", dapper "step_out", { silent = true } },
    { "<leader>dq", dapper "terminate", { silent = true } },
    { "<leader>dc", dapper "clear_breakpoints", { silent = true } },
  },
  init = function()
    setup_signs()
  end,
  dependencies = {
    {
      "theHamsta/nvim-dap-virtual-text",
      config = true,
    },
    {
      "rcarriga/nvim-dap-ui",
      keys = {
        {
          "<leader>du",
          function()
            require("dapui").toggle()
          end,
        },
      },
      config = function()
        local dap = require "dap"
        local dapui = require "dapui"
        dapui.setup()
        dap.listeners.after.event_initialized["dapui_config"] = dapui.open
        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
        dap.listeners.before.event_exited["dapui_config"] = dapui.close
      end,
    },
    {
      "nvim-telescope/telescope-dap.nvim",
      keys = {
        {
          "<leader>dB",
          function()
            require("telescope").extensions.dap.list_breakpoints()
          end,
          { silent = true },
        },
      },
      config = function()
        require("telescope").load_extension "dap"
      end,
      dependencies = { "nvim-lua/telescope.nvim" },
    },
    {
      "leoluz/nvim-dap-go",
      keys = {
        {
          "<leader>dt",
          function()
            require("dap-go").debug_test()
          end,
          { silent = true },
        },
        {
          "<leader>dT",
          function()
            require("dap-go").debug_last_test()
          end,
          { silent = true },
        },
      },
      config = true,
    },
    {
      "ofirgall/goto-breakpoints.nvim",
      keys = {
        {
          "]d",
          function()
            require("goto-breakpoints").next()
          end,
        },
        {
          "[d",
          function()
            require("goto-breakpoints").prev()
          end,
        },
      },
    },
  },
}
