return {
  "NeogitOrg/neogit",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "sindrets/diffview.nvim",
    "nvim-telescope/telescope.nvim",
    "ibhagwan/fzf-lua",
  },
  opts = {},
  keys = {
    { "<leader>G", "<Cmd>Neogit<CR>" },
  },
  cmd = "Neogit",
}
