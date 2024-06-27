---@diagnostic disable: inject-field
return {
  "kristijanhusak/vim-dadbod-ui",
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  keys = {
    { "<leader>D", "<Cmd>DBUIToggle<CR>" },
  },
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
  },
  init = function()
    -- vim.g.db_ui_use_nerd_fonts = 1
    vim.g.dbs = {
      ["data-insights"] = "postgresql://apiuser:password@localhost:5432/datainsights",
    }
    vim.g.db_ui_icons = {
      expanded = {
        db = "-",
        buffers = "-",
        saved_queries = "-",
        schemas = "-",
        schema = "-",
        tables = "-",
        table = "-",
      },
      collapsed = {
        db = "▪",
        buffers = "▪",
        saved_queries = "▪",
        schemas = "▪",
        schema = "▪",
        tables = "▪",
        table = "▪",
      },
    }
    vim.g.db_ui_execute_on_save = 1
    vim.g.db_ui_use_nvim_notify = 0
  end,
}
