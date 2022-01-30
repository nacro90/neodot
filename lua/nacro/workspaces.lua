local M = {}

function M.setup()
  require("workspaces").setup()

  vim.keymap.set("n", "<leader>w", "<Cmd>Telescope workspaces<CR>")
end

return M
