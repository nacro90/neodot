local function config()
  local filename = {
    "filename",
    separator = { left = "", right = "" },
    newfile_status = true,
    symbols = {
      readonly = "",
    },
  }
  local function dbui()
    local text = vim.fn["db_ui#statusline"]()
    return vim.startswith(text, "DBUI") and "" or text
  end
  local winbar_diagnostics = {
    "diagnostics",
    sources = { "nvim_diagnostic" },
    sections = { "error", "warn" },
    symbols = { error = "▪", warn = "▴", info = "›", hint = "▸" },
    padding = { left = 0, right = 1 },
    separator = { left = "", right = "" },
  }
  local recording = require "nacro.recording"
  local arrow = {
    function()
      return require("arrow.statusline").text_for_statusline_with_icons()
    end,
    separator = { left = "", right = "" },
    padding = { left = 0, right = 1 },
  }
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
        function()
          local exists, autosession = pcall(require, "auto-session.lib")
          if not exists then
            return ""
          end
          return autosession.current_session_name()
        end,
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
        arrow,
        winbar_diagnostics,
      },
      lualine_c = {
        {
          "navic",
          color_correction = "dynamic",
          draw_empty = true,
        },
        dbui,
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
        arrow,
        winbar_diagnostics,
        dbui,
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
    {
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
    "otavioschwanck/arrow.nvim",
  },
  config = config,
}
