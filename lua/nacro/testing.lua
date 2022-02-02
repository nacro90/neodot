local M = {}

local keymap = vim.keymap

local function setup_keymaps()
  keymap.set("n", "<leader>tt", "<Plug>(ultest-run-nearest)")
  keymap.set("n", "<leader>tl", "<Plug>(ultest-run-last)")
  keymap.set("n", "<leader>tf", "<Plug>(ultest-run-file)")
  keymap.set("n", "<leader>ts", "<Plug>(ultest-output-show)")
  keymap.set("n", "<leader>tj", "<Plug>(ultest-output-jump)")
  keymap.set("n", "<leader>tS", "<Plug>(ultest-summary-toggle)")
  keymap.set("n", "]t", "<Plug>(ultest-next-fail)")
  keymap.set("n", "[t", "<Plug>(ultest-prev-fail)")
end

local function setup_signs()
  vim.g.ultest_pass_sign = "●"
  vim.g.ultest_running_sign = "●"
  vim.g.ultest_fail_sign = "●"
end

function M.setup()
  setup_keymaps()
  setup_signs()
end

return M
