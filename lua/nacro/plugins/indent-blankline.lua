local function config()
  require("indent_blankline").setup {
    char = "·",
    show_trailing_blankline_indent = false,
    max_indent_increase = 2,
    char_highlight_list = {
      "IndentBlanklineChar",
    },
    indent_blankline_filetype_exclude = {
      "norg",
    },
    show_current_context = true,
    context_char = "·",
    context_highlight_list = {
      "CursorLineNr",
    },
  }
end

return {
  "lukas-reineke/indent-blankline.nvim",
  config = config,
}
