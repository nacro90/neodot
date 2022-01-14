local M = {}

local keymap = vim.keymap

local ledger_path = vim.env.HOME .. "/Ledgers/investment.ledger"

function M.edit()
  vim.cmd("edit " .. ledger_path)
end

function M.setup(path)
  ledger_path = path or ledger_path
  keymap.set("n", "<leader>el", M.edit)
end

return M
