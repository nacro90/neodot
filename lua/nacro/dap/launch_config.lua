-- Launch Configuration Loader
-- Supports .nvim/dap.lua (Lua) and .vscode/launch.json (JSON)
local M = {}

-- Project root detection markers
local ROOT_MARKERS = { "go.mod", ".git", ".nvim", ".vscode" }

--- Substitute VSCode-style variables in strings
---@param str string|any
---@param workspace string
---@return string|any
local function substitute_variables(str, workspace)
  if type(str) ~= "string" then
    return str
  end
  return str
    :gsub("%${workspaceFolder}", workspace)
    :gsub("%${file}", vim.fn.expand "%:p")
    :gsub("%${fileBasename}", vim.fn.expand "%:t")
    :gsub("%${fileDirname}", vim.fn.expand "%:p:h")
    :gsub("%${relativeFile}", vim.fn.expand "%:.")
    :gsub("%${cwd}", vim.fn.getcwd())
    :gsub("%${env:([%w_]+)}", function(var)
      return os.getenv(var) or ""
    end)
end

--- Recursively substitute variables in a table
---@param tbl table
---@param workspace string
---@return table
local function substitute_in_table(tbl, workspace)
  local result = {}
  for k, v in pairs(tbl) do
    if type(v) == "table" then
      result[k] = substitute_in_table(v, workspace)
    elseif type(v) == "string" then
      result[k] = substitute_variables(v, workspace)
    else
      result[k] = v
    end
  end
  return result
end

--- Find project root by looking for marker files/directories
---@param start_path? string
---@return string
function M.find_project_root(start_path)
  local path = start_path or vim.fn.expand "%:p:h"

  -- Handle empty buffer
  if path == "" or path == "." then
    path = vim.fn.getcwd()
  end

  while path ~= "/" and path ~= "" do
    for _, marker in ipairs(ROOT_MARKERS) do
      local marker_path = path .. "/" .. marker
      if vim.fn.isdirectory(marker_path) == 1 or vim.fn.filereadable(marker_path) == 1 then
        return path
      end
    end
    path = vim.fn.fnamemodify(path, ":h")
  end

  return vim.fn.getcwd()
end

--- Load configurations from .nvim/dap.lua
---@param root string
---@return table|nil
local function load_lua_config(root)
  local lua_path = root .. "/.nvim/dap.lua"
  if vim.fn.filereadable(lua_path) ~= 1 then
    return nil
  end

  local ok, configs = pcall(dofile, lua_path)
  if not ok then
    vim.notify("Error loading .nvim/dap.lua: " .. tostring(configs), vim.log.levels.ERROR)
    return nil
  end

  if type(configs) ~= "table" then
    vim.notify(".nvim/dap.lua must return a table", vim.log.levels.ERROR)
    return nil
  end

  return configs
end

--- Clean JSON content for parsing (handle comments, trailing commas, control chars)
---@param content string
---@return string
local function clean_json(content)
  -- Remove // line comments (but not inside strings - simplified approach)
  content = content:gsub("([\n,{])%s*//[^\n]*", "%1")
  -- Remove /* */ block comments
  content = content:gsub("/%*.-%*/", "")
  -- Remove $schema line (common in VSCode configs)
  content = content:gsub('"$schema"[^,\n]*,?%s*', "")
  -- Remove trailing commas before ] or }
  content = content:gsub(",%s*]", "]")
  content = content:gsub(",%s*}", "}")
  -- Remove control characters except newline, tab, carriage return
  content = content:gsub("%c", function(c)
    local byte = string.byte(c)
    if byte == 9 or byte == 10 or byte == 13 then -- tab, newline, CR
      return c
    end
    return ""
  end)
  return content
end

--- Load configurations from .vscode/launch.json
---@param root string
---@return table|nil
local function load_vscode_config(root)
  local json_path = root .. "/.vscode/launch.json"
  if vim.fn.filereadable(json_path) ~= 1 then
    return nil
  end

  local lines = vim.fn.readfile(json_path)
  local content = table.concat(lines, "\n")
  content = clean_json(content)

  -- Try vim.json.decode first (more lenient), fall back to vim.fn.json_decode
  local ok, data = pcall(vim.json.decode, content)
  if not ok then
    -- Try vim.fn.json_decode as fallback
    ok, data = pcall(vim.fn.json_decode, content)
  end

  if not ok then
    vim.notify("Error parsing .vscode/launch.json: " .. tostring(data), vim.log.levels.ERROR)
    return nil
  end

  if not data or not data.configurations then
    return nil
  end

  -- Filter Go configurations only
  local go_configs = vim.tbl_filter(function(config)
    return config.type == "go"
  end, data.configurations)

  return go_configs
end

--- Load all configurations for the current project
---@return table configs, string root
function M.load_configurations()
  local root = M.find_project_root()

  -- Priority: .nvim/dap.lua > .vscode/launch.json
  local configs = load_lua_config(root) or load_vscode_config(root) or {}

  -- Apply variable substitution
  local processed = {}
  for i, config in ipairs(configs) do
    processed[i] = substitute_in_table(config, root)

    -- Ensure required fields
    processed[i].type = processed[i].type or "go"
    processed[i].request = processed[i].request or "launch"
  end

  return processed, root
end

--- Get a single configuration by name
---@param name string
---@return table|nil config, string|nil root
function M.get_configuration(name)
  local configs, root = M.load_configurations()
  for _, config in ipairs(configs) do
    if config.name == name then
      return config, root
    end
  end
  return nil, nil
end

--- Check if project has any debug configurations
---@return boolean
function M.has_configurations()
  local configs, _ = M.load_configurations()
  return #configs > 0
end

return M