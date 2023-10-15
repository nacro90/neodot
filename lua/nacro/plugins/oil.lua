return {
  "stevearc/oil.nvim",
  opts = {},
  config = true,
  keys = {
    { "-", "<Cmd>Oil<CR>", { desc = "Open parent directory" } },
  },
  cmd = "Oil",
  dependencies = { "nvim-tree/nvim-web-devicons" },
}
