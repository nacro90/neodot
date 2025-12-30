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
      name = "Flutter Chrome",
      program = "lib/main.dart",
      cwd = "${workspaceFolder}",
      args = { "-d", "chrome" },
    },
    {
      type = "dart",
      request = "launch",
      name = "Flutter Web Server",
      program = "lib/main.dart",
      cwd = "${workspaceFolder}",
      args = { "-d", "web-server" },
    },
    {
      type = "dart",
      request = "launch",
      name = "Flutter Linux",
      program = "lib/main.dart",
      cwd = "${workspaceFolder}",
      args = { "-d", "linux" },
    },
    {
      type = "dart",
      request = "launch",
      name = "Flutter Emulator",
      program = "lib/main.dart",
      cwd = "${workspaceFolder}",
      args = { "-d", "emulator-5554" },
    },
    {
      type = "dart",
      request = "launch",
      name = "Flutter Samsung",
      program = "lib/main.dart",
      cwd = "${workspaceFolder}",
      args = { "-d", "R5CW91RN97P" },
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
    -- Breakpoints
    {
      "<leader>db",
      function()
        require("persistent-breakpoints.api").toggle_breakpoint()
      end,
      desc = "Toggle breakpoint",
    },
    {
      "<leader>dc",
      function()
        require("persistent-breakpoints.api").clear_all_breakpoints()
      end,
      desc = "Clear all breakpoints",
    },
    -- Session control (NEW: smart functions)
    {
      "<leader>dd",
      function()
        require("nacro.dap.restart").smart_continue()
      end,
      desc = "Debug: start/continue",
    },
    {
      "<leader>dr",
      function()
        require("nacro.dap.restart").smart_restart()
      end,
      desc = "Debug: restart (rebuild)",
    },
    {
      "<leader>dR",
      function()
        require("nacro.dap.restart").run_last()
      end,
      desc = "Debug: run last config",
    },
    {
      "<leader>dp",
      function()
        require("nacro.dap.picker").pick_configuration()
      end,
      desc = "Debug: pick config",
    },
    {
      "<leader>da",
      function()
        require("nacro.dap.picker").attach_to_process()
      end,
      desc = "Debug: attach to process",
    },
    { "<leader>dq", dapper "terminate", desc = "Debug: terminate" },
    { "<leader>de", dapper "repl.open", desc = "Debug: open REPL" },
    -- Stepping
    {
      "<leader>dn",
      function()
        require("dap").step_over { askForTargets = true }
      end,
      desc = "Debug: step over",
    },
    {
      "<leader>dN",
      function()
        require("dap").step_back { askForTargets = true }
      end,
      desc = "Debug: step back",
    },
    {
      "<leader>di",
      function()
        require("dap").step_into { askForTargets = true }
        require("goto-breakpoints").stopped()
      end,
      desc = "Debug: step into",
    },
    { "<leader>do", dapper "step_out", desc = "Debug: step out" },
  },
  init = function()
    setup_signs()
  end,
  dependencies = {
    {
      "rcarriga/nvim-dap-ui",
      dependencies = {
        "nvim-neotest/nvim-nio",
      },
      keys = {
        {
          "<leader>du",
          function()
            require("dapui").toggle()
          end,
          desc = "Debug: toggle UI",
        },
        {
          "<leader>K",
          function()
            require("dapui").float_element()
          end,
          desc = "Debug: float element",
        },
        {
          "K",
          function()
            require("dapui").eval()
          end,
          mode = { "n", "v" },
          desc = "Debug: evaluate",
        },
      },
      config = function()
        local dap = require "dap"
        local dapui = require "dapui"
        dapui.setup {
          icons = {
            collapsed = "▸",
            current_frame = "▶",
            expanded = "▾",
          },
          floating = {
            border = "solid",
            max_height = 0.9,
            max_width = 0.9,
          },
          layouts = {
            {
              elements = {
                { id = "scopes", size = 0.5 },
                { id = "repl", size = 0.5 },
              },
              position = "bottom",
              size = 10,
            },
          },
          controls = {
            enabled = true,
            element = "scopes",
            icons = {
              pause = "⏸",
              play = "▶",
              step_into = "↓",
              step_over = "→",
              step_out = "↑",
              step_back = "←",
              run_last = "⟳",
              terminate = "■",
            },
          },
        }
        -- Auto-open UI on debug start
        dap.listeners.after.event_initialized["dapui_open"] = function()
          dapui.open()
        end
        dap.listeners.before.event_exited["dapui_config"] = dapui.close
        dap.listeners.after.event_stopped["jump_to_execution"] = function(_, __)
          vim.defer_fn(function()
            require("goto-breakpoints").stopped()
          end, 50)
        end
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
          desc = "Debug: list breakpoints",
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
          desc = "Debug: test at cursor",
        },
        {
          "<leader>dT",
          function()
            require("dap-go").debug_last_test()
          end,
          desc = "Debug: last test",
        },
      },
      opts = {
        delve = {
          path = "/home/nacro90/.gvm/pkgsets/go1.23.6/global/bin/dlv",
        },
      },
    },
    {
      "mxsdev/nvim-dap-vscode-js",
      build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
      main = "dap-vscode-js",
      opts = {
        debugger_path = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug",
        adapters = {
          "pwa-node",
          "pwa-chrome",
          "pwa-msedge",
          "node-terminal",
          "pwa-extensionHost",
        },
      },
      dependencies = {
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
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
          desc = "Next breakpoint",
        },
        {
          "[b",
          function()
            require("goto-breakpoints").prev()
          end,
          desc = "Previous breakpoint",
        },
        {
          "<leader>ds",
          function()
            require("goto-breakpoints").stopped()
          end,
          desc = "Debug: go to stopped",
        },
      },
    },
    {
      "theHamsta/nvim-dap-virtual-text",
      opts = {
        virt_text_pos = "eol",
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
