local M = {}

local lualine = require "lualine"

local navic = require'nvim-navic'

local btc = require "nacro.lualine.btc"
local recording = require "nacro.lualine.recording"

local fn = vim.fn
local winwidth = fn.winwidth

local SMALL_WINDOW_THRESHOLD = 75

---@diagnostic disable-next-line: unused-local, unused-function
local function is_window_not_small()
  return winwidth(0) > SMALL_WINDOW_THRESHOLD
end

local function setup_lualine()
  lualine.setup {
    options = {
      theme = "auto",
      component_separators = { "│", "│" },
      section_separators = { "|", "|" },
      globalstatus = true,
    },
    sections = {
      lualine_a = {
        "mode",
        {
          recording.get_recording,
          cond = recording.is_recording,
        },
      },
      lualine_b = { "filename" },
      lualine_c = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          sections = { "error", "warn", "info", "hint" },
          color_error = "#F44747",
          color_warn = "#CE9178",
          color_info = "#BBBBBB",
          color_hint = "#BBBBBB",
          symbols = { error = "▪", warn = "▴", info = "›", hint = "▸" },
        },
{ navic.get_location, cond = navic.is_available }
      },
      lualine_x = {
        "searchcount",
        {
          btc.create_component_func(),
          cond = btc.is_enabled,
        },
        "branch",
        "encoding",
        "fileformat",
        "filetype",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "filetype" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    inactive_winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    extensions = { "nvim-tree", "fugitive" },
  }
end

function M.setup()
  recording.setup()
  setup_lualine()
end

return M
