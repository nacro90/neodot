return {
  "stevearc/overseer.nvim",
  opts = {
    -- strategy = "toggleterm",
    task_list = {
      default_detail = 1,
    },
  },
  keys = {
    { "<leader>vv", "<Cmd>OverseerToggle bottom<CR>" },
    { "<leader>vl", "<Cmd>OverseerLoadBundle<CR>" },
    { "<leader>vq", "<Cmd>OverseerQuickAction<CR>" },
    { "<leader>vt", "<Cmd>OverseerTaskAction<CR>" },
  },
}
