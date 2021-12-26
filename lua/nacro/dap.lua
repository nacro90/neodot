local nacro_dap = {}

local dap = require "dap"
local map = require "nacro.utils.map"
local command = require("nacro.utils.command").command

local cmd = vim.cmd
local fn = vim.fn

fn.sign_define(
  "DapBreakpoint",
  { text = "●", texthl = "ErrorMsg", linehl = "DiffDelete", numhl = "DiffDelete" }
)
fn.sign_define(
  "DapBreakpointRejected",
  { text = "∅", texthl = "NonText", linehl = "", numhl = "" }
)
fn.sign_define(
  "DapStopped",
  { text = "▶", texthl = "Constant", linehl = "Visual", numhl = "Visual" }
)

command("DapToggleBreakpoint", require("dap").toggle_breakpoint)
command("DapContinue", require("dap").continue)

dap.defaults.fallback.external_terminal = {
  command = "/usr/local/bin/alacritty",
  args = { "-e" },
}

dap.adapters.go = function(callback, config)
  local stdout = vim.loop.new_pipe(false)
  local handle
  local pid_or_err
  local port = 38697
  local opts = {
    stdio = { nil, stdout },
    args = { "dap", "-l", "127.0.0.1:" .. port },
    detached = true,
  }
  handle, pid_or_err = vim.loop.spawn("dlv", opts, function(code)
    stdout:close()
    handle:close()
    if code ~= 0 then
      print("dlv exited with code", code)
    end
  end)
  assert(handle, "Error running dlv: " .. tostring(pid_or_err))
  stdout:read_start(function(err, chunk)
    assert(not err, err)
    if chunk then
      vim.schedule(function()
        require("dap.repl").append(chunk)
      end)
    end
  end)
  -- Wait for delve to start
  vim.defer_fn(function()
    callback { type = "server", host = "127.0.0.1", port = port }
  end, 100)
end
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    program = "main.go",
  },
  {
    type = "go",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "main.go",
  },
  -- works with go.mod packages and sub packages
  {
    type = "go",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}",
  },
}

-- dap.configurations.java = {
--   {
--     type = "java",
--     request = "attach",
--     name = "Debug (Attach) - Remote",
--     hostName = "127.0.0.1",
--     port = 5005,
--   },
-- }
-- 
function nacro_dap.setup() end

return nacro_dap
