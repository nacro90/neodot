-- Java-specific telescope overrides with lazy loading
vim.keymap.set("n", "<leader>N", function()
  require("telescope.builtin").find_files { hidden = true, no_ignore = true }
end, {
  buffer = 0,
  desc = "Find all files (Java)",
})

vim.keymap.set("n", "<leader>n", function()
  require("telescope.builtin").find_files { path_display = { "tail" } }
end, {
  buffer = 0,
  desc = "Find files (tail display)",
})
