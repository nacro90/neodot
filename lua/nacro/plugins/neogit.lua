return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
    "ibhagwan/fzf-lua",
  },
  opts = {
    auto_show_console = false,
    graph_style = "unicode",
    integrations = {
      diffview = true,
    },
    signs = {
      item = { "▪", "-" },
      section = { "▪", "-" },
    },
  },
  keys = {
    { "<leader>G", "<Cmd>Neogit<CR>" },
  },
  cmd = "Neogit",
}
