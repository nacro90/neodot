return {
  "kristijanhusak/vim-dadbod-ui",
  cmd = {
    "DBUI",
    "DBUIToggle",
    "DBUIAddConnection",
    "DBUIFindBuffer",
  },
  dependencies = {
    { "tpope/vim-dadbod", lazy = true },
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.dbs = {
      ["data-insights"] = "postgresql://apiuser:password@localhost:5432/datainsights",
    }
  end,
}
