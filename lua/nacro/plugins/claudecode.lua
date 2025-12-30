return {
  "coder/claudecode.nvim",
  dependencies = { {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
  } },
  config = true,
  cmd = { "ClaudeCode" },
  keys = {
    { "<leader>cc", "<cmd>ClaudeCode<cr>",            desc = "Toggle Claude" },
    { "<leader>cf", "<cmd>ClaudeCodeFocus<cr>",       desc = "Focus Claude" },
    { "<leader>cr", "<cmd>ClaudeCode --resume<cr>",   desc = "Resume Claude" },
    { "<leader>cC", "<cmd>ClaudeCode --continue<cr>", desc = "Continue Claude" },
    { "<leader>cm", "<cmd>ClaudeCodeSelectModel<cr>", desc = "Select Claude model" },
    { "<leader>cb", "<cmd>ClaudeCodeAdd %<cr>",       desc = "Add current buffer" },
    {
      "<leader>cc",
      "<cmd>ClaudeCodeSend<cr>",
      mode = "v",
      desc = "Send to Claude",
    },
    {
      "<leader>cc",
      "<cmd>ClaudeCodeTreeAdd<cr>",
      desc = "Add file",
      ft = { "NvimTree", "neo-tree", "oil", "minifiles", "netrw" },
    },
    { "<leader>ca", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "Accept diff" },
    { "<leader>cd", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "Deny diff" },
  },
}
