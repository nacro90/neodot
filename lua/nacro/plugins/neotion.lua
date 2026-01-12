return {
  "nacro90/neotion.nvim",
  dev = true,
  opts = {
    api_token = vim.env.NOTION_API_TOKEN,
    log_level = "debug",
    conceal_level = 2,
    render = {
      gutter_icons = true,
    },
    keymaps = {
      enter_follows_link = true,
    },
  },
  cmd = { "Neotion" },
  keys = {
    { "<Space>N", "<Cmd>Neotion search<CR>", desc = "Neotion search" },
  },
  dependencies = {
    "kkharji/sqlite.lua",
  },
}
