local telescope = require "telescope"
local builtin = require "telescope.builtin"

vim.keymap.set("n", "<leader>N", function()
  builtin.find_files { hidden = true, no_ignore = true }
end, {
  buffer = 0,
})

vim.keymap.set("n", "<leader>n", function()
  builtin.find_files { path_display = { "tail" } }
end, {
  buffer = 0,
})
