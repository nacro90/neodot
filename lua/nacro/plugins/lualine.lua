local function config()
  local filename = {
    "filename",
    separator = { left = "", right = "" },
    newfile_status = true,
    symbols = {
      readonly = "",
    },
  }
  local winbar_diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = "▪", warn = "▴", info = "›", hint = "▸" },
    padding = { left = 0, right = 1 },
    separator = { left = "", right = "" },
  }
  local recording = require "nacro.recording"
  require("lualine").setup {
    options = {
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      globalstatus = true,
      disabled_filetypes = {
        winbar = {
          "NvimTree",
          "undotree",
          "OverseerList",
          "oil",
        },
      },
    },
    sections = {
      lualine_a = {
        "mode",
        {
          recording.get_recording,
          cond = recording.is_recording,
        },
      },
      lualine_b = {},
      lualine_c = {
        {
          function()
            return vim.fn.getcwd():gsub(vim.env.HOME, "~")
          end,
        },
      },
      lualine_x = { "selectioncount" },
      lualine_y = {
        "overseer",
        {
          function()
            return "⚙️ "
          end,
          cond = function()
            return #require("dap").sessions() > 0
          end,
        },
      },
      lualine_z = {
        {
          "progress",
          padding = { left = 1, right = 0 },
        },
        function()
          return "|"
        end,
        {
          "location",
          padding = { left = -1, right = 1 },
        },
      },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {
      lualine_a = {
        {
          "tabs",
          cond = function()
            return #vim.api.nvim_list_tabpages() > 1
          end,
          mode = 0,
          use_mode_colors = true,
          show_modified_status = false,
          tabs_color = {
            inactive = "lualine_b_inactive",
          },
        },
      },
      lualine_b = {},
      lualine_c = {},
      lualine_x = {
        require("auto-session.lib").current_session_name,
      },
      lualine_y = {},
      lualine_z = {},
    },
    winbar = {
      lualine_a = {},
      lualine_b = {
        {
          "filetype",
          icon_only = true,
          colored = true,
          padding = { left = 1, right = 0 },
          icon = { align = "left" },
        },
        filename,
        winbar_diagnostics,
      },
      lualine_c = {
        {
          "navic",
          color_correction = "dynamic",
          draw_empty = true,
        },
      },
      lualine_x = { "diff" },
      lualine_y = {},
      lualine_z = { "searchcount" },
    },
    inactive_winbar = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {
        {
          "filetype",
          icon_only = true,
          colored = false,
          padding = { left = 1, right = 0 },
        },
        filename,
        winbar_diagnostics,
      },
      lualine_x = { "diff" },
      lualine_y = { "searchcount" },
      lualine_z = {},
    },
    extensions = {
      "fugitive",
      "nvim-dap-ui",
      "overseer",
      "toggleterm",
      "mason",
      "trouble",
      "oil",
      "lazy",
      "man",
    },
  }

  recording.setup()
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "SmiteshP/nvim-navic",
    opts = {
      highlight = true,
      separator = "  ",
      click = true,
      lsp = {
        auto_attach = true,
      },
    },
  },
  config = config,
}
