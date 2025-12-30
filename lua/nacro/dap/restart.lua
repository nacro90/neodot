-- Smart Restart Module
-- Terminate + Rebuild + Restart in one action
local M = {}

-- State tracking
M.last_config = nil
M.last_root = nil

--- Build Go project with debug symbols
---@param root string Project root
---@param program string|nil Program path
---@param callback function Called on success
local function build_go_project(root, program, callback)
  -- Determine package to build
  local pkg_path = "."
  if program then
    local expanded = type(program) == "function" and program() or program
    pkg_path = vim.fn.fnamemodify(expanded, ":h")
    if not pkg_path:match "^/" then
      pkg_path = "./" .. pkg_path
    end
  end

  vim.notify("Building Go project...", vim.log.levels.INFO)

  local cmd = string.format("cd %s && go build -gcflags='all=-N -l' %s 2>&1", vim.fn.shellescape(root), pkg_path)

  local output = {}
  vim.fn.jobstart(cmd, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if data then
        vim.list_extend(output, data)
      end
    end,
    on_stderr = function(_, data)
      if data then
        vim.list_extend(output, data)
      end
    end,
    on_exit = function(_, exit_code)
      if exit_code == 0 then
        vim.schedule(function()
          vim.notify("Build successful", vim.log.levels.INFO)
          callback()
        end)
      else
        vim.schedule(function()
          local msg = table.concat(output, "\n")
          vim.notify("Build failed:\n" .. msg, vim.log.levels.ERROR)
        end)
      end
    end,
  })
end

--- Smart continue: pick config if no session, continue if active
function M.smart_continue()
  local dap = require "dap"

  if dap.session() then
    dap.continue()
  else
    local launch_config = require "nacro.dap.launch_config"
    if launch_config.has_configurations() then
      require("nacro.dap.picker").pick_configuration()
    else
      -- Fall back to nvim-dap-go defaults
      dap.continue()
    end
  end
end

--- Smart restart: terminate + rebuild + restart
function M.smart_restart()
  local dap = require "dap"

  if not dap.session() then
    vim.notify("No active debug session", vim.log.levels.WARN)
    return
  end

  -- Terminate current session
  dap.terminate(nil, nil, function()
    vim.schedule(function()
      local root = M.last_root or require("nacro.dap.launch_config").find_project_root()
      local program = M.last_config and M.last_config.program

      -- Skip build for attach sessions
      if M.last_config and M.last_config.request == "attach" then
        if M.last_config then
          require("nacro.dap.picker").run_configuration(M.last_config, root)
        end
        return
      end

      -- Build and restart
      build_go_project(root, program, function()
        if M.last_config then
          require("nacro.dap.picker").run_configuration(M.last_config, root)
        else
          dap.run_last()
        end
      end)
    end)
  end)
end

--- Run last configuration without rebuild
function M.run_last()
  local dap = require "dap"

  if M.last_config and M.last_root then
    require("nacro.dap.picker").run_configuration(M.last_config, M.last_root)
  else
    dap.run_last()
  end
end

--- Clear stored state
function M.clear()
  M.last_config = nil
  M.last_root = nil
end

return M
