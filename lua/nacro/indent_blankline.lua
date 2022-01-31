local M = {}

function M.setup()
  require("indent_blankline").setup {
    char = "·",
    show_current_context = true,
    show_trailing_blankline_indent = false,
    max_indent_increase = 2,
  }
end

return M
