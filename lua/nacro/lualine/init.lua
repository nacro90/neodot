local n_lualine = {}

local lualine = require "lualine"
local gps = require "nvim-gps"

local btc = require "nacro.lualine.btc"
local functional = require "nacro.functional"
local and_ = functional.and_

local fn = vim.fn
local winwidth = fn.winwidth

local function setup_gps()
  gps.setup {
    icons = {
      ["class-name"] = " ",
      ["function-name"] = " ",
      ["container-name"] = " ",
      ["tag-name"] = "<> ",
    },
    separator = " > ",
    depth = 3,
  }
end

local SMALL_WINDOW_THRESHOLD = 75

local function is_window_not_small()
  return winwidth(0) > SMALL_WINDOW_THRESHOLD
end

function n_lualine.setup()
  setup_gps()

  lualine.setup {
    options = {
      theme = "codedark",
      component_separators = { "│", "│" },
      section_separators = { "", "" },
    },
    sections = {
      lualine_a = {
        {
          "mode",
          fmt = function(str)
            return is_window_not_small() and str or str:sub(1, 1)
          end,
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
        { gps.get_location, cond = and_(gps.is_available, is_window_not_small) },
      },
      lualine_x = {
        { btc.create_component_func(), cond = and_(is_window_not_small, btc.is_enabled) },
        "branch",
        { "encoding", cond = is_window_not_small },
        { "fileformat", cond = is_window_not_small },
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
    extensions = { "nvim-tree", "fugitive" },
  }
end

return n_lualine
