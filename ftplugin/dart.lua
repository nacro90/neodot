vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.keymap.set("n", "<leader>mp", "mlBi_`ll", { buffer = 0 })

vim.api.nvim_create_autocmd("TextChanged", {
  group = vim.api.nvim_create_augroup("flutter_log_view_attacher", {}),
  pattern = "__FLUTTER_DEV_LOG__",
  callback = function()
    local cursor = vim.api.nvim_win_get_cursor(0)
    local line_count = vim.api.nvim_buf_line_count(0)
    if cursor[1] < line_count - 20 then
      return
    end
    local new_cursor = { line_count, cursor[2] }
    vim.api.nvim_win_set_cursor(0, new_cursor)
  end,
})

vim.opt.commentstring = "// %s"

vim.keymap.set("n", "<leader>n", function()
  require("telescope.builtin").find_files { search_file = ".*\\.dart" }
end)
