local function dart()
  local dap = require "dap"

  dap.adapters.dart = {
    type = "executable",
    command = "flutter",
    args = { "debug_adapter" },
  }
  dap.configurations.dart = {
    {
      type = "dart",
      request = "launch",
      name = "Launch Flutter Program",
      program = "lib/main.dart",
      cwd = "${workspaceFolder}",
      args = { "-d", "linux" },
    },
  }
end

local function setup_signs()
  vim.fn.sign_define("DapBreakpoint", {
    text = "⬤",
    texthl = "ErrorMsg",
    linehl = "DapBreakpointLine",
    numhl = "DapBreakpointLine",
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
    linehl = "DapExecutionLine",
    numhl = "DapExecutionLine",
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
    {
      "<leader>db",
      function()
        require("persistent-breakpoints.api").toggle_breakpoint()
      end,
      { silent = true },
    },
    { "<leader>dd", dapper "continue", { silent = true } },
    { "<leader>dr", dapper "restart", { silent = true } },
    { "<leader>dn", dapper "step_over", { silent = true } },
    { "<leader>dN", dapper "run_to_cursor", { silent = true } },
    { "<leader>di", dapper "step_into", { silent = true } },
    { "<leader>do", dapper "step_out", { silent = true } },
    { "<leader>dq", dapper "terminate", { silent = true } },
    {
      "<leader>dc",
      function()
        require("persistent-breakpoints.api").clear_all_breakpoints()
      end,
      { silent = true },
    },
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
        {
          "<leader>K",
          function()
            require("dapui").float_element()
          end,
        },
        {
          "K",
          function()
            require("dapui").eval()
          end,
          mode = { "n", "v" },
        },
      },
      config = function()
        local dap = require "dap"
        local dapui = require "dapui"
        dapui.setup {
          icons = {
            collapsed = "▪",
            current_frame = "▸",
            expanded = "-",
          },
          floating = {
            border = "solid",
          },
          layouts = {
            {
              elements = {
                {
                  id = "stacks",
                  size = 0.2,
                },
                {
                  id = "scopes",
                  size = 0.8,
                },
              },
              position = "bottom",
              size = 10,
            },
          },
        }
        dap.listeners.after.event_initialized["dapui_config"] = dapui.open
        dap.listeners.before.event_terminated["dapui_config"] = dapui.close
        dap.listeners.before.event_exited["dapui_config"] = dapui.close
        dart()
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
      dependencies = { "nvim-telescope/telescope.nvim" },
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
      opts = {
        dap_configurations = {
          {
            type = "go",
            name = "UberCloud Data Insights",
            request = "launch",
            program = "cmd/server/main.go",
            args = {
              "--debug",
              "--port",
              "3000",
              "--static",
              "../build/web",
              "--db",
              "postgresql://apiuser:password@localhost:5432/datainsights",
              "--metricstore",
              "http://localhost:9090",
              "--enable-swagger",
            },
          },
          {
            type = "go",
            name = "MiniSera Backend",
            request = "launch",
            program = "cmd/minisera/main.go",
            args = {},
          },
        },
        delve = {
          args = {
            "--check-go-version=false",
          },
        },
      },
    },
    {
      "ofirgall/goto-breakpoints.nvim",
      keys = {
        {
          "]b",
          function()
            require("goto-breakpoints").next()
          end,
        },
        {
          "[b",
          function()
            require("goto-breakpoints").prev()
          end,
        },
        {
          "<leader>ds",
          function()
            require("goto-breakpoints").stopped()
          end,
        },
      },
    },
    {
      "Weissle/persistent-breakpoints.nvim",
      event = "BufReadPost",
      config = function()
        require("persistent-breakpoints").setup {
          load_breakpoints_event = { "BufReadPost" },
        }
      end,
    },
  },
}
