local function config()
  local recording = require "nacro.recording"
  require("lualine").setup {
    options = {
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
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
        {
          function()
            return require("nvim-navic").get_location()
          end,
          cond = function()
            if #vim.lsp.get_active_clients() == 0 then
              return false
            end
            local exists, navic = pcall(require, "nvim-navic")
            if not exists then
              return false
            end
            return navic.is_available()
          end,
        },
      },
      lualine_x = {
        "tabs",
        "searchcount",
        "selectioncount",
        "encoding",
        "filetype",
      },
      lualine_y = { "branch" },
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
    tabline = {
      lualine_a = {
        {
          "tabs",
          mode = 2,
          use_mode_colors = true,
          tabs_color = {
            inactive = "lualine_b_inactive", -- Color for inactive tab.
          },
        },
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
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

  recording.setup()
end

return {
  "nvim-lualine/lualine.nvim",
  config = config,
}
