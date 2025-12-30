-- Telescope Pickers for DAP
-- Configuration picker and process picker for attach
local M = {}

local launch_config = require "nacro.dap.launch_config"

--- Convert VSCode launch.json config to nvim-dap format
---@param config table
---@param root string
---@return table
local function normalize_config(config, root)
  local resolved = {}

  for k, v in pairs(config) do
    if type(v) == "function" then
      resolved[k] = v()
    else
      resolved[k] = v
    end
  end

  -- For launch requests, don't set mode (nvim-dap-go handles it)
  -- mode is only needed for attach requests
  if resolved.request == "launch" and resolved.mode then
    -- Only keep mode if it's a valid nvim-dap-go mode
    if resolved.mode ~= "debug" and resolved.mode ~= "test" then
      resolved.mode = nil
    end
  end

  -- Ensure outputMode is set to "remote" so stdout goes to REPL via DAP OutputEvents
  if resolved.request == "launch" and not resolved.outputMode then
    resolved.outputMode = "remote"
  end

  -- Expand working directory
  if resolved.cwd then
    resolved.cwd = vim.fn.expand(resolved.cwd)
  else
    resolved.cwd = root
  end

  -- Expand program path relative to root
  if resolved.program and not resolved.program:match "^/" then
    resolved.program = root .. "/" .. resolved.program
  end

  return resolved
end

--- Run a debug configuration
---@param config table
---@param root string
function M.run_configuration(config, root)
  local dap = require "dap"
  local restart = require "nacro.dap.restart"

  -- Store for smart restart
  restart.last_config = config
  restart.last_root = root

  local resolved = normalize_config(config, root)
  dap.run(resolved)
end

--- Pick and run a debug configuration using Telescope
---@param opts? table Telescope options
function M.pick_configuration(opts)
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"

  opts = opts or {}
  local configs, root = launch_config.load_configurations()

  if #configs == 0 then
    vim.notify("No debug configurations found. Using nvim-dap-go defaults.", vim.log.levels.INFO)
    require("dap").continue()
    return
  end

  pickers
    .new(opts, {
      prompt_title = "Debug Configurations",
      finder = finders.new_table {
        results = configs,
        entry_maker = function(config)
          local icon = config.request == "attach" and "󰌘 " or "󰐊 "
          local display = icon .. config.name
          if config.program then
            local program = type(config.program) == "function" and "[dynamic]" or config.program
            display = display .. " (" .. vim.fn.fnamemodify(program, ":t") .. ")"
          end
          return {
            value = config,
            display = display,
            ordinal = config.name,
          }
        end,
      },
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, _)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if selection then
            M.run_configuration(selection.value, root)
          end
        end)
        return true
      end,
    })
    :find()
end

--- Get list of running Go processes
---@return table[]
local function get_go_processes()
  local handle = io.popen [[ps -eo pid,comm,args --no-headers 2>/dev/null | grep -E '(^[0-9]+\s+(go|dlv|__debug_bin)|\.test\s)' | grep -v grep]]
  if not handle then
    return {}
  end

  local result = handle:read "*a"
  handle:close()

  local processes = {}
  for line in result:gmatch "[^\n]+" do
    local pid, rest = line:match "^%s*(%d+)%s+(.+)$"
    if pid then
      table.insert(processes, {
        pid = tonumber(pid),
        cmd = vim.trim(rest),
      })
    end
  end

  return processes
end

--- Pick a Go process and attach debugger
---@param opts? table Telescope options
function M.pick_go_process(opts)
  local pickers = require "telescope.pickers"
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values
  local actions = require "telescope.actions"
  local action_state = require "telescope.actions.state"

  opts = opts or {}
  local processes = get_go_processes()

  if #processes == 0 then
    vim.notify("No Go processes found", vim.log.levels.WARN)
    return
  end

  pickers
    .new(opts, {
      prompt_title = "Attach to Go Process",
      finder = finders.new_table {
        results = processes,
        entry_maker = function(entry)
          return {
            value = entry,
            display = string.format("[%d] %s", entry.pid, entry.cmd:sub(1, 80)),
            ordinal = tostring(entry.pid) .. " " .. entry.cmd,
          }
        end,
      },
      sorter = conf.generic_sorter(opts),
      attach_mappings = function(prompt_bufnr, _)
        actions.select_default:replace(function()
          actions.close(prompt_bufnr)
          local selection = action_state.get_selected_entry()
          if selection then
            M.attach_to_pid(selection.value.pid)
          end
        end)
        return true
      end,
    })
    :find()
end

--- Attach debugger to a specific PID
---@param pid number
function M.attach_to_pid(pid)
  local dap = require "dap"
  local restart = require "nacro.dap.restart"

  local config = {
    type = "go",
    name = "Attach: " .. pid,
    request = "attach",
    mode = "local",
    processId = pid,
  }

  restart.last_config = config
  restart.last_root = launch_config.find_project_root()

  dap.run(config)
end

--- Attach to process (main entry point)
function M.attach_to_process()
  M.pick_go_process()
end

return M