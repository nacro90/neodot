local nnoremap = require("nacro.utils.map").nnoremap

local vim = vim
local api = vim.api
local cmd = vim.cmd
local fn = vim.fn

local bufnr = api.nvim_get_current_buf()

local function flatten_buf()
  local lines = api.nvim_buf_get_lines(bufnr, 0, -1, true)
  lines = vim.tbl_map(function(line)
    return line:gsub("^%s+", ""):gsub("%s+$", "")
  end, lines)
  local joined = table.concat(lines):gsub("\n", "")
  api.nvim_buf_set_lines(bufnr, 0, -1, true, { joined })
end

local function format_buf()
  -- jq is way faster than builtin python json formatting
  local formatter = fn.executable "jq" == 1 and "jq --indent 4" or "python -m json.tool"
  cmd("%!" .. formatter)
end

-- Flatten the json and remove the white spaces for oneline sending (e.g Kafka event)
nnoremap("gL", flatten_buf, bufnr)
nnoremap("gl", format_buf, bufnr)
