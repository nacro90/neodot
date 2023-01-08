local nnoremap = require("nacro.utils.map").nnoremap

local vim = vim
local api = vim.api
local cmd = vim.cmd
local fn = vim.fn

vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

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
  local indent = vim.v.count ~= 0 and vim.v.count or 2
  local jq_cmd = ("jq --indent %d"):format(math.min(indent, 7))
  local py_cmd = ("python -m json.tool --indent %d"):format(indent)
  local formatter = fn.executable "jq" == 1 and jq_cmd or py_cmd
  cmd("silent %!" .. formatter)
end

-- Flatten the json and remove the white spaces for oneline sending (e.g Kafka event)
nnoremap("gL", flatten_buf, bufnr)
nnoremap("gl", format_buf, bufnr)
